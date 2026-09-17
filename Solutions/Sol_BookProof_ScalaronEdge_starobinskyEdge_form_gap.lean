-- Generated from ChapterScalaronEdge.lean — solution of BookProof.ScalaronEdge.starobinskyEdge_form_gap
import Mathlib
import Definitions.Def_ChapterScalaronEdge
import Theorems.Thm_BookProof_ScalaronEdge_scalV_nonneg
import Theorems.Thm_BookProof_ScalaronEdge_starobinskyV_lt_shelf_bounded
import Theorems.Thm_BookProof_ScalaronEdge_edgeKinConst_pos
import Theorems.Thm_BookProof_ScalaronEdge_edgeMassConst_pos
import Theorems.Thm_BookProof_ScalaronEdge_edge_energy_bound
import Theorems.Thm_BookProof_ScalaronEdge_starobinskyEdge_quadForm_eq
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
      E₀ * ‖(ψ : Lp ℂ 2 (volume : Measure ℝ))‖ ^ 2
        ≤ quadForm (starobinskyEdgeHam M alpha) ψ := by

  obtain ⟨A, B, hA, hB, hbound⟩ :=
    starobinskyV_lt_shelf_bounded M alpha hM halpha c hc hcs
  refine ⟨min (edgeKinConst A B) (edgeMassConst c),
    lt_min (edgeKinConst_pos hA hB) (edgeMassConst_pos hc), ?_⟩
  intro ψ
  obtain ⟨f, rfl⟩ := (ccEquiv ℝ).surjective ψ
  have hVcont : Continuous (scalV M alpha) := (scalV_smooth M alpha).continuous
  have hVout : ∀ x, x ∉ Set.Icc (-A) B → c ≤ scalV M alpha x := by
    intro x hx
    exact le_of_not_gt fun hlt => hx (hbound x hlt)
  have hmain := edge_energy_bound hA hB hc (scalV M alpha) hVcont
    (scalV_nonneg M alpha halpha) hVout ((f : 𝓢(ℝ, ℂ)) : ℝ → ℂ)
    ((f : 𝓢(ℝ, ℂ)).smooth 2) f.2
  rw [starobinskyEdge_quadForm_eq, ccEquiv_norm_sq]
  exact hmain
