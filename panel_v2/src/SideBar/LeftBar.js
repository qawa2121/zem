import React from 'react';
import SideBarTitle from './SideBarTitle';
import SideBarMenu from './SideBarMenu';

// Наше меню слева
const LeftBar = () => (
    <nav id="sidebar">
        <SideBarTitle title="Electro V2" />
        <SideBarMenu />{/** Именно меню */}
    </nav>
);

export default LeftBar;
