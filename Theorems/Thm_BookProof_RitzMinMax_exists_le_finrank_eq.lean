-- Generated from ChapterSirkRitzMinMax.lean — theorem BookProof.RitzMinMax.exists_le_finrank_eq
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterSirkRitzSpectrum
import Mathlib
import Definitions.Def_ChapterSirkRitzMinMax
open BookProof.RitzMinMax

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]


noncomputable section


open BookProof.HermiteGalerkin BookProof.ChapterSirkRitzSpectrum
open Filter Topology


theorem BookProof.RitzMinMax.exists_le_finrank_eq {S : Submodule ℂ F} [FiniteDimensional ℂ S] {n : ℕ}
    (hn : n ≤ Module.finrank ℂ S) :
    ∃ S₀ : Submodule ℂ F, S₀ ≤ S ∧ Module.finrank ℂ S₀ = n := by sorry
