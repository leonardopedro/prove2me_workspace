-- Generated from ChapterHermiteFunctions.lean — solution of BookProof.HermiteCore.hermiteLp_span_dense
import Mathlib
import Definitions.Def_ChapterHermiteFunctions
import Theorems.Thm_BookProof_HermiteCore_memLp_poly_mul_gaussH
import Theorems.Thm_BookProof_HermiteCore_ae_eq_zero_of_moments
open BookProof.HermiteCore




open MeasureTheory Polynomial Filter Topology FourierTransform SchwartzMap

noncomputable section

set_option maxHeartbeats 1000000 in
p_congr _ _ (Filter.Eventually.of_forall fun x => ?_)
      rw [hr]
      simp only [Polynomial.eval_add, Polynomial.eval_sub]
      ring_nf
    rw [hsplit, toLp_hermiteR_smul]
    exact Submodule.add_mem _ (ih r hrdeg)
      (Submodule.smul_mem _ :=
  _ (Submodule.subset_span ⟨n + 1, rfl⟩))
  
  theorem poly_mul_gaussH_mem_span (p : Polynomial ℝ) :
      (memLp_poly_mul_gaussH p).toLp _ ∈ Submodule.span ℂ (Set.range hermiteLp) :=
    poly_mul_gaussH_mem_span_aux p.natDegree p le_rfl
  
  /-- **Completeness of the Hermite functions**: their span is dense in `L²(ℝ)`. -/
  theorem hermiteLp_span_dense :
      (⊤ : Submodule ℂ (Lp ℂ 2 (volume : Measure ℝ)))
        ≤ (Submodule.span ℂ (Set.range hermiteLp)).topologicalClosure := by
    rw [top_le_iff, Submodule.topologicalClosure_eq_top_iff, Submodule.eq_bot_iff]
    intro u hu
    have hmom : ∀ k : ℕ, ∫ x : ℝ, ((x ^ k * gaussH x : ℝ) : ℂ) * (u : ℝ → ℂ) x = 0 := by
      intro k
      have hmem := poly_mul_gaussH_mem_span (X ^ k)
      have hinner : (inner ℂ ((memLp_poly
