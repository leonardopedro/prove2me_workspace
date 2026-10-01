-- Generated from ChapterQgOuterFockFlow.lean — theorem BookProof.QgOuterFockFlow.comparison_dom_dense
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterQgOuterFockCoreFL
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterEsaClosureCore
import Mathlib
import Definitions.Def_ChapterQgOuterFockFlow
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterNavierStokesCanonicalVector
import Definitions.Def_ChapterQgOuterFockFarisLavine
import Definitions.Def_ChapterA4
open BookProof.NavierStokesFlow.CanonicalVector
open BookProof.QgOuterFockFL



open Filter Topology
open BookProof.FarisLavine BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.StoneBridge BookProof.ChapterStoneResolvent BookProof.EsaClosure
open BookProof.ChapterSirkTrotterKato

noncomputable section

theorem BookProof.QgOuterFockFlow.comparison_dom_dense {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
    [CompleteSpace F] (C : Comparison F) : Dense ((C.dom : Submodule ℂ F) : Set F) := by sorry
