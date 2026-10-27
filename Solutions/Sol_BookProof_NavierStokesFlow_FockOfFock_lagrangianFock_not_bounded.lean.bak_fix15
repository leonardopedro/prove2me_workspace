-- Generated from ChapterNavierStokesFockEsa.lean — solution of BookProof.NavierStokesFlow.FockOfFock.lagrangianFock_not_bounded
import Mathlib
import Definitions.Def_ChapterNavierStokesFockEsa
import Theorems.Thm_BookProof_NavierStokesFlow_FockOfFock_dGamma_not_bounded
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockOfFock



open MeasureTheory



open FullEsa LagrangianEsa

variable {M : Type*} [DecidableEq M]
variable {M : Type*} [DecidableEq M] {Ω : Type*} [MeasurableSpace Ω]
variable {J K : Type*} [DecidableEq J] [DecidableEq K]

set_option maxHeartbeats 1000000 in
theorem solution (nu : ℝ) (p q dr : Fin 3 → M → ℝ) (force : Fin 3 → ℝ)
    (cst : M → ℝ) (h : ∀ C : ℝ, ∃ m, C < |lagSymbol nu p q dr force cst m|) :
    ¬ ((∃ C : ℝ, ∀ f : FockDom M, ‖hFockLag nu p q dr force cst f‖ ≤ C * ‖f‖)) := dGamma_not_bounded _ h
