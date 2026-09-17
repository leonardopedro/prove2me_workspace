-- Generated from ChapterScalaronEdge.lean — solution of BookProof.ScalaronEdge.starobinskyEdge_quadForm
import Mathlib
import Definitions.Def_ChapterScalaronEdge
import Theorems.Thm_BookProof_ScalaronEdge_starobinskyEdge_inner_eq
import Theorems.Thm_BookProof_ScalaronEdge_starobinskyEdge_self_inner
import Theorems.Thm_BookProof_ScalaronEdge_starobinskyEdge_quadForm_eq
import Theorems.Thm_BookProof_ScalaronEdge_starobinskyEdge_form_gap
open BookProof.ScalaronEdge










open Complex Real MeasureTheory Function SchwartzMap ComplexOrder
open BookProof.Starobinsky
open BookProof.ScalaronWallEsa
open BookProof.ScalaronEsa
open BookProof.FarisLavine
open BookProof.WallEsaSemibounded
open BookProof.FriedrichsExtension
open BookProof.FriedrichsFormGap
open BookProof.YangMillsFriedrichs
open BookProof.HashimotoShiftInvert



variable (M alpha : ℝ)

set_option maxHeartbeats 1000000 in
theorem solution (hM : 0 < M) (halpha : 0 < alpha) (c : ℝ) (hc : 0 < c)
    (hcs : c < edgeShelf M alpha) :
    ∃ E₀ : ℝ, 0 < E₀ ∧ ∀ ψ : ccDomain ℝ,
      (inner ℂ (starobinskyEdgeHam M alpha ψ)
          ((ψ : Lp ℂ 2 (volume : Measure ℝ))) : ℂ)
        ≥ (E₀ : ℂ) * inner ℂ ((ψ : Lp ℂ 2 (volume : Measure ℝ)))
            ((ψ : Lp ℂ 2 (volume : Measure ℝ))) := by

  obtain ⟨E₀, hE₀, hgap⟩ := starobinskyEdge_form_gap M alpha hM halpha c hc hcs
  refine ⟨E₀, hE₀, fun ψ => ?_⟩
  obtain ⟨f, rfl⟩ := (ccEquiv ℝ).surjective ψ
  have hgapf := hgap (ccEquiv ℝ f)
  rw [starobinskyEdge_quadForm_eq, ccEquiv_norm_sq] at hgapf
  rw [starobinskyEdge_inner_eq, starobinskyEdge_self_inner, ← Complex.ofReal_mul, ge_iff_le,
    Complex.real_le_real]
  exact hgapf
