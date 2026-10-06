-- Generated from ChapterScalaronDensitizedTransfer.lean — solution of BookProof.ScalaronDensitized.integral_norm_sq_eq_norm_sq
import Mathlib
import Definitions.Def_ChapterScalaronDensitizedTransfer
open BookProof.ScalaronDensitized




open MeasureTheory Set Filter Topology
open BookProof.Starobinsky BookProof.QuantumGravityDensitized
open BookProof.QuantumGravityHalfDensity
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.FockContinuum
open BookProof.FarisLavine BookProof.StoneBridge
open BookProof.ChapterStoneResolvent BookProof.EsaClosure

noncomputable section

variable (M alpha : ℝ)
variable {X : Type*} [MeasurableSpace X]

set_option maxHeartbeats 1000000 in
theorem solution (mu : Measure X) (f : Lp ℂ 2 mu) :
    ∫ a, ‖(f : X → ℂ) a‖ ^ 2 ∂mu = ‖f‖ ^ 2 := by

  have key : ∀ z : ℂ, (inner ℂ z z : ℂ) = ((‖z‖ ^ 2 : ℝ) : ℂ) := by
    intro z
    rw [inner_self_eq_norm_sq_to_K]
    norm_cast
  have h1 : (inner ℂ f f : ℂ) = ∫ a, (inner ℂ ((f : X → ℂ) a) ((f : X → ℂ) a) : ℂ) ∂mu :=
    L2.inner_def f f
  have h2 : (inner ℂ f f : ℂ) = ((‖f‖ ^ 2 : ℝ) : ℂ) := by
    rw [inner_self_eq_norm_sq_to_K]; norm_cast
  have h3 : ∫ a, (inner ℂ ((f : X → ℂ) a) ((f : X → ℂ) a) : ℂ) ∂mu
      = ((∫ a, ‖(f : X → ℂ) a‖ ^ 2 ∂mu : ℝ) : ℂ) := by
    rw [← integral_complex_ofReal]
    exact integral_congr_ae (Filter.Eventually.of_forall fun a => key _)
  rw [h3] at h1
  rw [h1] at h2
  exact_mod_cast h2
