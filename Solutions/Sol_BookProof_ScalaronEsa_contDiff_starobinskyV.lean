-- Generated from ChapterScalaronCoreEsa.lean — solution of BookProof.ScalaronEsa.contDiff_starobinskyV
import Mathlib
import Definitions.Def_ChapterScalaronCoreEsa
open BookProof.ScalaronEsa



open Filter Topology MeasureTheory SchwartzMap


open BookProof.StrichartzWave BookProof.FarisLavine BookProof.Starobinsky
open BookProof.QuantumGravityDensitized BookProof.StoneBridge BookProof.NavierStokesFlow
open BookProof.ChapterStoneResolvent BookProof.EsaClosure

noncomputable section

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]
  [MeasurableSpace E] [BorelSpace E]

set_option maxHeartbeats 1000000 in
theorem solution (M alpha : ℝ) :
    ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (fun phi : ℝ => starobinskyV M alpha phi) := by

  unfold starobinskyV
  exact contDiff_const.mul
    ((contDiff_const.sub (Real.contDiff_exp.comp
      ((contDiff_const.mul contDiff_id).div_const M))).pow 2)
