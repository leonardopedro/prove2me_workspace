-- Generated from ChapterScalaronCoreEsa.lean — solution of BookProof.ScalaronEsa.mulCc_apply
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

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]
  [MeasurableSpace E] [BorelSpace E]

set_option maxHeartbeats 1000000 in
def opCc (W : E → ℝ) (hW : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) W) :
    ccDomain E →ₗ[ℂ] Lp ℂ 2 (volume : Measure E) := rfl
