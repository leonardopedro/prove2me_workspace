-- Generated from ChapterQgOuterFockFlow.lean — theorem BookProof.QgOuterFockFlow.comparison_dom_dense
import Mathlib
import Definitions.Def_ChapterQgOuterFockFlow
open BookProof.QgOuterFockFlow



open Filter Topology
open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.QgContinuumModeInstance
open BookProof.FarisLavine BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.StoneBridge BookProof.ChapterStoneResolvent BookProof.EsaClosure
open BookProof.ChapterSirkTrotterKato

noncomputable section

theorem BookProof.QgOuterFockFlow.comparison_dom_dense {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
    [CompleteSpace F] (C : Comparison F) : Dense ((C.dom : Submodule ℂ F) : Set F) := by sorry
