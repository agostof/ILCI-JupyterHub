#!/usr/bin/env python

import urllib.parse
import argparse


def generate_jupyterhub_url(hub_url, repo_owner, repo_name, path_to_open, branch="main"):
    if repo_owner:
        full_repo_name = f"{repo_owner}/{repo_name}"
    else:
        full_repo_name = f"{repo_name}"
        
    repo = f"https://github.com/{full_repo_name}"
    urlpath = f"lab/tree/{repo_name}/{path_to_open}"
    
    encoded_repo = urllib.parse.quote_plus(repo)
    encoded_urlpath = urllib.parse.quote_plus(urlpath)
    
    return f"{hub_url}/hub/user-redirect/git-pull?repo={encoded_repo}&urlpath={encoded_urlpath}&branch={branch}"


def parse_arguments():
    #https://github.com/CornellILCI/ILCI-CIAP-Workshops/blob/main/Onboarding_20240703/03_reading_data/demo_1_read_local_data.ipynb
    parser = argparse.ArgumentParser(
        description="Generate JupyterHub URL for GitHub repository.",
        epilog="Example usage:\n"
               "python create_nbgitpuller_link.py --hub-url \"https://ciap.ilci.scienceversa.com\" \\\n"
               "                      --repo-owner \"CornellILCI\" \\\n"
               "                      --repo-name \"ILCI-CIAP-Workshops\" \\\n"
               "                      --path-to-open \"Onboarding_20240703/03_reading_data/demo_1_read_local_data.ipynb\" \\\n"
               "                      --branch \"main\"",
        formatter_class=argparse.RawTextHelpFormatter
    )
    
    parser.add_argument("--hub-url", required=True, help="Base URL for your JupyterHub instance.")
    parser.add_argument("--repo-owner", help="GitHub User or Organization name.")
    parser.add_argument("--repo-name", required=True, help="Repository name.")
    parser.add_argument("--path-to-open", required=True, help="Path to the file in the repository to open.")
    parser.add_argument("--branch", default="main", help="Branch name (default is 'main').")
    parser.add_argument("--inline", action='store_true', help="Print the URL without a newline.")
    parser.add_argument("--markdown", action='store_true', help="Print markdown source for the URL.")

    return parser#.parse_args()

def main():
    parser = parse_arguments()
    try:
        args = parser.parse_args()
    except argparse.ArgumentError as exc:
        print(exc.message, file=sys.stderr)
        parser.print_help()
        sys.exit(1)
    
    hub_url = args.hub_url
    repo_owner = args.repo_owner
    repo_name = args.repo_name
    path_to_open = args.path_to_open
    branch = args.branch
    inline = args.inline
    markdown = args.markdown

    url = generate_jupyterhub_url(hub_url, repo_owner, repo_name, path_to_open, branch)
      
    if inline:
        print(url, end='')
    elif markdown:
        print(f"Paste this in your makdown document:\n[{path_to_open}]({url})")
    else:
        print(f"""############################~~~~ DESCRIPTION ~~~~####################################\nThe URL below will open\n
{path_to_open} at {hub_url}\n\n
############################~~~~ NOTEBOOK LINK ~~~~####################################
>>>>>>>COPY_PASTE

{url}

<<<<<<<END
############################^^^^ NOTEBOOK LINK ^^^^####################################


############################~~~ MARKDOWN OPTION ~~~####################################

To add as a link to a markdown paste this code in markdown:

>>>>>>>COPY_PASTE_MARKDOWN

Example link to open notebook: [{path_to_open}]({url})

<<<<<<<END_MARKDOWN

""")


if __name__ == "__main__":
    main()

