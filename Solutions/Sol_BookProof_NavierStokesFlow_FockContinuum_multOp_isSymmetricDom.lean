-- Generated from ChapterNavierStokesFockContinuum.lean — solution of BookProof.NavierStokesFlow.FockContinuum.multOp_isSymmetricDom
import Mathlib
import Definitions.Def_ChapterNavierStokesFockContinuum
import Theorems.Thm_BookProof_ChapterLinftyMultiplication_multOp_coeFn
import Definitions.Def_ChapterLinftyMultiplication
import Definitions.Def_ChapterNavierStokesFullEsa
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockContinuum



open MeasureTheory



open FullEsa
open BookProof.ChapterLinftyMultiplication
open BookProof.NavierStokesFlow.FullEsa.NSFullData

variable {X : Type*} [MeasurableSpace X]

variable {X : Type*} [MeasurableSpace X]

private theorem multOp_coeFn (μ : Measure X) {g : X → ℝ} (hg : Measurable g)
    (f : boundedEnergyCore μ g) :
    (((multOp μ hg f : boundedEnergyCore μ g) : Lp ℂ 2 μ) : X → ℂ)
      =ᵐ[μ] fun x => (g x : ℂ) * ((f : Lp ℂ 2 μ) : X → ℂ) x :=
  (memLp_mul hg f.2).coeFn_toLp

set_option maxHeartbeats 1000000 in

theorem solution (μ : Measure X) {g : X → ℝ} (hg : Measurable g) :
    IsSymmetricDom (multOp μ hg) := by
  intro x y
  rw [L2.inner_def, L2.inner_def]
  refine integral_congr_ae ?_
  filter_upwards [multOp_coeFn μ hg x, multOp_coeFn μ hg y] with a hx hy
  simp only [RCLike.inner_apply, hx, hy, map_mul, Complex.conj_ofReal]
  ring
