-- Generated from ChapterScalarDGammaEsa.lean — solution of BookProof.ScalarDGamma.isGraphCore_scalarOp
import Mathlib
import Definitions.Def_ChapterScalarDGammaEsa
open BookProof.ScalarDGamma




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore

noncomputable section

variable (Hs : IPSpace) (c : ℝ)

variable (Hs : IPSpace) (c : ℝ)

set_option maxHeartbeats 1000000 in
theorem solution {D : Submodule ℂ Hs.carrier}
    (hdense : Dense (D : Set Hs.carrier)) : IsGraphCore D (scalarOp Hs c) := by

  intro x ε hε
  have hden : (0 : ℝ) < 1 + |c| := by positivity
  have hpos : 0 < ε / (1 + |c|) := by positivity
  obtain ⟨y, hyD, hy⟩ := Metric.mem_closure_iff.mp (hdense (x : Hs.carrier)) _ hpos
  have hxy : ‖(x : Hs.carrier) - y‖ < ε / (1 + |c|) := by rw [← dist_eq_norm]; exact hy
  have hmul : (1 + |c|) * ‖(x : Hs.carrier) - y‖ < ε := by
    have := (mul_lt_mul_of_pos_left hxy hden)
    calc (1 + |c|) * ‖(x : Hs.carrier) - y‖ < (1 + |c|) * (ε / (1 + |c|)) := this
      _ = ε := by field_simp
  have hnn : 0 ≤ ‖(x : Hs.carrier) - y‖ := norm_nonneg _
  refine ⟨⟨y, trivial⟩, hyD, ?_, ?_⟩
  · nlinarith [abs_nonneg c]
  · have hEq : scalarOp Hs c x - scalarOp Hs c ⟨y, trivial⟩
        = (c : ℂ) • ((x : Hs.carrier) - y) := by
      simp only [scalarOp_apply]
      rw [smul_sub]
    rw [hEq, norm_smul]
    have hc : ‖(c : ℂ)‖ = |c| := by simp
    rw [hc]
    nlinarith
