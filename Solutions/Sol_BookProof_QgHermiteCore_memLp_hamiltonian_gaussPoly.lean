-- Generated from ChapterQgHermiteCore.lean — solution of BookProof.QgHermiteCore.memLp_hamiltonian_gaussPoly
import Mathlib
import Definitions.Def_ChapterQgHermiteCore
import Theorems.Thm_BookProof_QgHermiteCore_memLp_gaussPoly
import Theorems.Thm_BookProof_QgHermiteCore_memLp_mul_gaussPoly_of_expBounded
import Theorems.Thm_BookProof_QgHermiteCore_deriv2_gaussPoly
import Definitions.Def_ChapterStarobinskyPotential
import Definitions.Def_ChapterHermiteFunctions
open BookProof.QgHermiteCore














open MeasureTheory Polynomial Filter Topology
open BookProof.HermiteCore BookProof.Starobinsky







variable {E : Type*} [NormedAddCommGroup E]

set_option maxHeartbeats 1000000 in
theorem solution {W : ℝ → ℝ} (hW : Continuous W) (hWb : ExpBounded W)
    (p : Polynomial ℝ) :
    MemLp (fun x : ℝ =>
        ((-deriv (deriv (gaussPoly p)) x + W x * gaussPoly p x : ℝ) : ℂ)) 2
      (volume : Measure ℝ) := by

  have h1 : MemLp (fun x : ℝ =>
      ((-gaussPoly (gaussPolyDeriv (gaussPolyDeriv p)) x : ℝ) : ℂ)) 2 (volume : Measure ℝ) := by
    have hneg := (memLp_gaussPoly (gaussPolyDeriv (gaussPolyDeriv p))).neg
    refine (memLp_congr_ae (Filter.Eventually.of_forall fun x => ?_)).mp hneg
    simp only [Pi.neg_apply, Complex.ofReal_neg]
  have h2 := memLp_mul_gaussPoly_of_expBounded hW hWb p
  have hsum := h1.add h2
  refine (memLp_congr_ae (Filter.Eventually.of_forall fun x => ?_)).mp hsum
  rw [deriv2_gaussPoly]
  simp only [Pi.add_apply]
  push_cast
  ring
