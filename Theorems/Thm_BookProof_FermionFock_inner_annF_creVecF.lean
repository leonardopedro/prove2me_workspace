-- Generated from ChapterFermionFock.lean — theorem BookProof.FermionFock.inner_annF_creVecF
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterComplexShiftCore
import Definitions.Def_ChapterFockSecondQuantization
import Mathlib
import Definitions.Def_ChapterFermionFock
import Definitions.Def_ChapterSmCarAlgebra
import Definitions.Def_ChapterA4
open BookProof.SmCar
open BookProof.FermionFock



open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.YangMillsFriedrichs
open BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization (IsHermCol IsPosCol opCol isHermCol_opCol isPosCol_opCol)

noncomputable section

theorem BookProof.FermionFock.inner_annF_creVecF (col : ℕ → (ℕ →₀ ℂ)) (u v : FermiAlg) (j : ℕ) {L : Finset ℕ}
    (h : (col j).support ⊆ L) :
    (inner ℂ (toLpF u) (toLpF (creVecF (col j) (annF j v))) : ℂ)
      = ∑ k ∈ L, (col j) k * inner ℂ (toLpF (annF k u)) (toLpF (annF j v)) := by sorry
