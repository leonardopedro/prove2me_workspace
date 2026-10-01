-- Generated from ChapterHermiteFunctions.lean — theorem BookProof.HermiteCore.hermiteLp_span_dense
import Mathlib
import Definitions.Def_ChapterHermiteFunctions
open BookProof.HermiteCore



open MeasureTheory Polynomial Filter Topology FourierTransform SchwartzMap

noncomputable section

p_congr _ _ (Filter.Eventually.of_forall fun x => ?_)
      rw [hr]
      simp only [Polynomial.eval_add, Polynomial.eval_sub]
      ring_nf
    rw [hsplit, toLp_hermiteR_smul]
    exact Submodule.add_mem _ (ih r hrdeg)
      (Submodule.smul_mem _ := by sorry
