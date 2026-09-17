-- Generated from ChapterScalaronCoreEsa.lean — theorem BookProof.ScalaronEsa.integral_conj_mul_smoothPotential_sub_eq_zero
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

theorem BookProof.ScalaronEsa.integral_conj_mul_smoothPotential_sub_eq_zero (W : E → ℝ)
    (hW : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) W) (z : ℂ)
    (u : Lp ℂ 2 (volume : Measure E))
    (hu : ∀ v : ccDomain E,
      (inner ℂ (opCc W hW v) u : ℂ) = z * inner ℂ (v : Lp ℂ 2 _) u)
    (ψ : ccSchwartz E) :
    ∫ x, (starRingEnd ℂ) ((ψ : 𝓢(E, ℂ)) x) * (((W x : ℝ) : ℂ) - z) * (u x) = 0 := by sorry
