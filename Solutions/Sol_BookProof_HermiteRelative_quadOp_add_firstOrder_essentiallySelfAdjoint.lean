-- Generated from ChapterHermiteRelativeBound.lean — solution of BookProof.HermiteRelative.quadOp_add_firstOrder_essentiallySelfAdjoint
import Mathlib
import Definitions.Def_ChapterHermiteRelativeBound
import Theorems.Thm_BookProof_HermiteRelative_foOp_symmetric
import Theorems.Thm_BookProof_HermiteRelative_norm_foOp_le
open BookProof.HermiteRelative










open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HyperbolicQuadratic

noncomputable section



variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] {ι : Type*}





variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (c : Fin d → ℝ) {c0 : ℝ} (hc0 : 0 < c0)
    (hc : ∀ i, c0 ≤ c i) (b b' : Fin d → ℝ) :
    EssentiallySelfAdjointOn (polyGaussCore (d := d)) (quadOp c + foOp b b') := by

  classical
  set K : ℝ := ∑ i, (|b i| + |b' i|) with hK
  have hK0 : 0 ≤ K := Finset.sum_nonneg fun i _ => by positivity
  set e : ℝ := 1 / (2 * (K + 1)) with he
  have he0 : 0 < e := by
    have : 0 < 2 * (K + 1) := by linarith
    positivity
  refine BookProof.KatoRellich.essentiallySelfAdjointOn_add_relBounded _ _ (quadOp_symmetric c)
    (quadOp_essentiallySelfAdjoint c) (foOp_symmetric b b') (a := K * e)
    (b := K * (2 / (c0 * e))) (by positivity) ?_ (by positivity) ?_
  · rw [he]
    rw [mul_one_div, div_lt_one (by linarith)]
    linarith
  · intro u
    have h := norm_foOp_le c hc0 hc b b' he0 u
    calc ‖foOp b b' u‖ ≤ K * (e * ‖quadOp c u‖ + (2 / (c0 * e)) * ‖(u : L2d d)‖) := h
      _ = K * e * ‖quadOp c u‖ + K * (2 / (c0 * e)) * ‖(u : L2d d)‖ := by ring
