/*
 * ******************************************************************************
 *   Copyright (c) 2019 Symplectic. All rights reserved.
 *   This Source Code Form is subject to the terms of the Mozilla Public
 *   License, v. 2.0. If a copy of the MPL was not distributed with this
 *   file, You can obtain one at http://mozilla.org/MPL/2.0/.
 * ******************************************************************************
 *   Version :  ${git.branch}:${git.commit.id}
 * ******************************************************************************
 */

package uk.co.symplectic.vivoweb.harvester.utils;
import uk.co.symplectic.vivoweb.harvester.model.ElementsItemType;

/**
 * Helper Class to represent the Elements groups that are actually going to be included in (includedGroups)
 * Also represents the set of groups that will be "excised" from Vivo (excisedGroups)
 */
public class IncludedGroups {
    private final ElementsItemKeyedCollection.ItemRestrictor restrictToGroupsOnly = new ElementsItemKeyedCollection.RestrictToType(ElementsItemType.GROUP);
    private final ElementsItemKeyedCollection.ItemInfo includedGroups = new ElementsItemKeyedCollection.ItemInfo(restrictToGroupsOnly);
    private final ElementsItemKeyedCollection.ItemInfo excisedGroups = new ElementsItemKeyedCollection.ItemInfo(restrictToGroupsOnly);

    public ElementsItemKeyedCollection.ItemInfo getIncludedGroups(){
        return includedGroups;
    }

    public ElementsItemKeyedCollection.ItemInfo getExcisedGroups() {
        return excisedGroups;
    }
}
