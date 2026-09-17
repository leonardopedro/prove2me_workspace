-- Generated from ChapterScalaronEdge.lean — solution of BookProof.ScalaronEdge.scalaronEdge_friedrichs_gap
import Mathlib
import Definitions.Def_ChapterScalaronEdge
import Theorems.Thm_BookProof_ScalaronEdge_starobinskyEdgeHam_symmetricOn
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
    ∃ E₀ : ℝ, 0 < E₀ ∧ ∃ (Dom : Submodule ℂ (Lp ℂ 2 (volume : Measure ℝ)))
      (A : Dom →ₗ[ℂ] Lp ℂ 2 (volume : Measure ℝ))
      (S : Lp ℂ 2 (volume : Measure ℝ) →L[ℂ] Lp ℂ 2 (volume : Measure ℝ)),
      IsPositiveSelfAdjointExtension (starobinskyEdgeHam M alpha) A ∧ IsShiftInvert A 1 S ∧
        IsSelfAdjoint S ∧ (∀ y : Dom, E₀ * ‖(y : Lp ℂ 2 (volume : Measure ℝ))‖ ^ 2
          ≤ quadForm A y) := by

  obtain ⟨E₀, hE₀, hgap⟩ := starobinskyEdge_form_gap M alpha hM halpha c hc hcs
  have hpos : ∀ x : ccDomain ℝ, 0 ≤ quadForm (starobinskyEdgeHam M alpha) x := by
    intro x
    have := hgap x
    have h2 : 0 ≤ E₀ * ‖(x : Lp ℂ 2 (volume : Measure ℝ))‖ ^ 2 := by positivity
    linarith
  let P : PosSymOp (Lp ℂ 2 (volume : Measure ℝ)) :=
    { dom := ccDomain ℝ
      op := starobinskyEdgeHam M alpha
      sym := starobinskyEdgeHam_symmetricOn M alpha
      pos := hpos }
  obtain ⟨Dom, A, S, hext, hshift, hsa, hlow⟩ :=
    friedrichs_extension_form_gap P ccDomain_dense hgap
  exact ⟨E₀, hE₀, Dom, A, S, hext, hshift, hsa, hlow⟩
