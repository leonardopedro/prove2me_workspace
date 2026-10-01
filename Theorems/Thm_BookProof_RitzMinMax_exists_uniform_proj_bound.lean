-- Generated from ChapterSirkRitzMinMax.lean — theorem BookProof.RitzMinMax.exists_uniform_proj_bound
import Definitions.Def_ChapterSirkRitzSpectrum
import Mathlib
import Definitions.Def_ChapterSirkRitzMinMax
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
open BookProof.HermiteGalerkin
open BookProof.RitzMinMax

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]


noncomputable section


open BookProof.HermiteGalerkin BookProof.ChapterSirkRitzSpectrum
open Filter Topology


theorem BookProof.RitzMinMax.exists_uniform_proj_bound (b : HilbertBasis ℕ ℂ F) (S : Submodule ℂ F)
    [FiniteDimensional ℂ S] {ε : ℝ} (hε : 0 < ε) :
    ∃ m₀ : ℕ, ∀ m ≥ m₀, ∀ x ∈ S,
      ‖(galerkinSpan b m).starProjection x - x‖ ≤ ε * ‖x‖ := by sorry
