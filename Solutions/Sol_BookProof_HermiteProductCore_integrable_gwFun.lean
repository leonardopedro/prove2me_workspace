-- Generated from ChapterHermiteProductCore.lean — solution of BookProof.HermiteProductCore.integrable_gwFun
import Mathlib
import Definitions.Def_ChapterHermiteProductCore
import Theorems.Thm_BookProof_HermiteProductCore_gwFun_eq
open BookProof.HermiteProductCore








open MeasureTheory Complex MvPolynomial BookProof.HermiteCore
open scoped FourierTransform
open SchwartzMap

noncomputable section



variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (r : MvPolynomial (Fin d) ℂ) :
    Integrable (fun x : Vd d =>
      MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) r * (gaussWD x : ℂ)) := by

  refine (integrable_mul_of_memLp_two (memLp_pgFun r) (memLp_pgFun 1)).congr
    (Filter.Eventually.of_forall fun x => ?_)
  simpa using (gwFun_eq r x).symm
