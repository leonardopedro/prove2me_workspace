-- Generated from ChapterScalaronCoreEsa.lean — solution of BookProof.ScalaronEsa.smoothPotential_symmetric
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
theorem solution (W : E → ℝ)
    (hW : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) W) :
    SymmetricOn (ccDomain E) (opCc W hW) := by

  intro x y
  obtain ⟨f, rfl⟩ := (ccEquiv E).surjective x
  obtain ⟨g, rfl⟩ := (ccEquiv E).surjective y
  rw [opCc_apply, opCc_apply, ccEquiv_coe, ccEquiv_coe, inner_toLp_left, inner_toLp_left]
  refine integral_congr_ae ?_
  filter_upwards [(g : 𝓢(E, ℂ)).coeFn_toLp 2 (volume : Measure E),
    (mulCc W hW g).coeFn_toLp 2 (volume : Measure E)] with x hx hy
  rw [hx, hy]
  simp only [mulCc_apply, map_mul, Complex.conj_ofReal]
  ring
