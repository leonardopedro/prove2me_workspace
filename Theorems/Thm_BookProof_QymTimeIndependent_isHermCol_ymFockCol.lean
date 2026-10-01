-- Generated from ChapterQymTimeIndependentFlow.lean — theorem BookProof.QymTimeIndependent.isHermCol_ymFockCol
import Mathlib
import Definitions.Def_ChapterQymTimeIndependentFlow
open BookProof.QymTimeIndependent

variable (e : ℕ ≃ (Fin 99 →₀ ℕ)) (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ)



open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge
open BookProof.HashimotoShiftInvert BookProof.SirkSingleTime BookProof.QgTimeIndependent
open BookProof.FiniteSectionSingleTime BookProof.YangMillsFriedrichs
open BookProof.FockSecondQuantization BookProof.QgCouplingDGammaSum
open BookProof.YangMillsHermite BookProof.HermiteGalerkin BookProof.HermiteProd

uctCore
open BookProof.NavierStokesFlow

noncomputable section

variable (e : ℕ ≃ (Fin 99 →₀ ℕ)) ( := by sorry
