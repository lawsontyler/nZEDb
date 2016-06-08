<?xml version="1.0" encoding="utf-8"?>
<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom" xmlns:nZEDb="{$serverroot}rss-info/">
	<channel>
		<atom:link href="{$serverroot}{$smarty.server.REQUEST_URI|escape:"htmlall"|substr:1}" rel="self" type="application/rss+xml" />
		<title>{$site->title|escape}</title>
		<description>{$site->title|escape} Nzb Feed</description>
		<link>{$serverroot}</link>
		<language>en-gb</language>
		<webMaster>{$site->email} ({$site->title|escape})</webMaster>
		<category>{$site->meta_keywords}</category>
		<image>
			<url>{$serverroot}themes/shared/img/logo.png</url>
			<title>{$site->title|escape}</title>
			<link>{$serverroot}</link>
			<description>Visit {$site->title|escape} - {$site->strapline|escape}</description>
		</image>
		{foreach from=$releases item=release}
			<item>
				<title>{$release.searchname|escape:html}</title>
				<guid isPermaLink="true">{$serverroot}details/{$release.guid}</guid>
				<link>{$serverroot}{if $dl == "1"}getnzb{else}details{/if}/{$release.guid}{if $dl == "1"}.nzb&amp;i={$uid}&amp;r={$rsstoken}{/if}{if $del == "1"}&amp;del=1{/if}</link>
				<comments>{$serverroot}details/{$release.guid}#comments</comments>
				<pubDate>{$release.adddate|phpdate_format:"DATE_RSS"}</pubDate>
				<category>{$release.category_name|escape:html}</category>
				<description>{if $api == "1"}{$release.searchname}{else}
					<![CDATA[{strip}
					<div>
						{if $release.cover == 1}
							<img style="margin-left:10px;margin-bottom:10px;float:right;" src="{$serverroot}covers/movies/{$release.imdbid}-cover.jpg" width="120" alt="{$release.searchname|escape:"htmlall"}" />
						{/if}
						{if $release.mu_cover == 1}
							<img style="margin-left:10px;margin-bottom:10px;float:right;" src="{$serverroot}covers/music/{$release.musicinfo_id}.jpg" width="120" alt="{$release.searchname|escape:"htmlall"}" />
						{/if}
						{if $release.co_cover == 1}
							<img style="margin-left:10px;margin-bottom:10px;float:right;" src="{$serverroot}covers/console/{$release.consoleinfo_id}.jpg" width="120" alt="{$release.searchname|escape:"htmlall"}" />
						{/if}
						{if $release.bo_cover == 1}
							<img style="margin-left:10px;margin-bottom:10px;float:right;" src="{$serverroot}covers/book/{$release.bookinfo_id}.jpg" width="120" alt="{$release.searchname|escape:"htmlall"}" />
						{/if}
						<ul>
							<li>ID: <a href="{$serverroot}details/{$release.guid}">{$release.guid}</a></li>
							<li>Name: {$release.searchname}</li>
							<li>Size: {$release.size|fsize_format:"MB"} </li>
							<li>Attributes: Category - <a href="{$serverroot}browse?t={$release.categories_id}">{$release.category_name}</a></li>
							<li>Groups: <a href="{$serverroot}browse?g={$release.group_name}">{$release.group_name}</a></li>
							<li>Poster: {$release.fromname|escape:"htmlall"}</li>
							<li>PostDate: {$release.postdate|phpdate_format:"DATE_RSS"}</li>
							<li>Password: {if $release.passwordstatus == 0}None{elseif $release.passwordstatus == 1}Possibly Passworded Archive{elseif $release.passwordstatus == 2}Probably not viable{elseif $release.passwordstatus == 10}Passworded Archive{else}Unknown{/if}</li>
							{if $release.nfoid != ""}
								<li>Nfo: <a href="{$serverroot}api?t=getnfo&amp;id={$release.guid}&amp;raw=1&amp;i={$uid}&amp;r={$rsstoken}">{$release.searchname}.nfo</a></li>
							{/if}
							{if $release.parentCategoryid == {$catClass::MOVIE_ROOT}}
								{if $release.imdbid != ""}
									<li>Imdb Info:
										<ul>
											<li>IMDB Link: <a href="http://www.imdb.com/title/tt{$release.imdbid}/">{$release.searchname}</a></li>
											{if $release.rating != ""}<li>Rating: {$release.rating}</li>{/if}
											{if $release.plot != ""}<li>Plot: {$release.plot}</li>{/if}
											{if $release.year != ""}<li>Year: {$release.year}</li>{/if}
											{if $release.genre != ""}<li>Genre: {$release.genre}</li>{/if}
											{if $release.director != ""}<li>Director: {$release.director}</li>{/if}
											{if $release.actors != ""}<li>Actors: {$release.actors}</li>{/if}
										</ul>
									</li>
								{/if}
							{/if}
							{if $release.parentCategoryid == {$catClass::MUSIC_ROOT}}
								{if $release.musicinfo_id > 0}
									<li>Music Info:
										<ul>
											{if $release.mu_url != ""}<li>Amazon: <a href="{$release.mu_url}">{$release.mu_title}</a></li>{/if}
											{if $release.mu_artist != ""}<li>Artist: {$release.mu_artist}</li>{/if}
											{if $release.mu_genre != ""}<li>Genre: {$release.mu_genre}</li>{/if}
											{if $release.mu_publisher != ""}<li>Publisher: {$release.mu_publisher}</li>{/if}
											{if $release.year != ""}<li>Released: {$release.mu_releasedate|date_format}</li>{/if}
											{if $release.mu_review != ""}<li>Review: {$release.mu_review}</li>{/if}
											{if $release.mu_tracks != ""}
												<li>Track Listing:
													<ol>
														{assign var="tracksplits" value="|"|explode:$release.mu_tracks}
														{foreach from=$tracksplits item=tracksplit}
															<li>{$tracksplit|trim}</li>
														{/foreach}
													</ol>
												</li>
											{/if}
										</ul>
									</li>
								{/if}
							{/if}
							{if $release.parentCategoryid == {$catClass::GAME_ROOT}}
								{if $release.consoleinfo_id > 0}
									<li>Console Info:
										<ul>
											{if $release.co_url != ""}<li>Amazon: <a href="{$release.co_url}">{$release.co_title}</a></li>{/if}
											{if $release.co_genre != ""}<li>Genre: {$release.co_genre}</li>{/if}
											{if $release.co_publisher != ""}<li>Publisher: {$release.co_publisher}</li>{/if}
											{if $release.year != ""}<li>Released: {$release.co_releasedate|date_format}</li>{/if}
											{if $release.co_review != ""}<li>Review: {$release.co_review}</li>{/if}
										</ul>
									</li>
								{/if}
							{/if}
						</ul>
					</div>
					<div style="clear:both;">
						{/strip}]]>
						{/if}
				</description>
				{if $dl == "1"}<enclosure url="{$serverroot}getnzb/{$release.guid}.nzb&amp;i={$uid}&amp;r={$rsstoken}{if $del == "1"}&amp;del=1{/if}" length="{$release.size}" type="application/x-nzb" />{/if}
				{foreach from=$release.category_ids|parray:"," item=cat}
					<nZEDb:attr name="category" value="{$cat}" />
				{/foreach}
				<nZEDb:attr name="size" value="{$release.size}" />
				<nZEDb:attr name="files" value="{$release.totalpart}" />
				<nZEDb:attr name="poster" value="{$release.fromname|escape:html}" />
				{if $release.videos_id > 0}
					<nZEDb:attr name="videos_id" value="{$release.videos_id}" />
				{/if}
				{if $release.tv_episodes_id > 0}
					<nZEDb:attr name="episode" value="{$release.tv_episodes_id}" />
				{/if}
				{if $release.imdbid != ""}
					<nZEDb:attr name="imdb" value="{$release.imdbid}" />
				{/if}
				<nZEDb:attr name="grabs" value="{$release.grabs}" />
				<nZEDb:attr name="comments" value="{$release.comments}" />
				<nZEDb:attr name="password" value="{$release.passwordstatus}" />
				<nZEDb:attr name="usenetdate" value="{$release.postdate|phpdate_format:"DATE_RSS"}" />
				<nZEDb:attr name="group" value="{$release.group_name|escape:html}" />
			</item>
		{/foreach}
	</channel>
</rss>