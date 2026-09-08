-- Generated from ChapterQgHermiteOscillatorEsa.lean — solution of BookProof.QgHermiteOscillator.hamCore_add_potential
import Mathlib
import Definitions.Def_ChapterQgHermiteOscillatorEsa
import Theorems.Thm_BookProof_QgHermiteOscillator_potCore_pgLp
open BookProof.QgHermiteOscillator












open MeasureTheory Complex MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs BookProof.FarisLavine
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section



variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
  {ι : Type*} {D : Submodule ℂ F}





variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (V W : Vd d → ℝ) (hVc : Continuous V) (hVb : ExpBounded V)
    (hWc : Continuous W) (hWb : ExpBounded W)
    (hsc : Continuous fun x => V x + W x) (hsb : ExpBounded fun x => V x + W x) :
    hamCore (fun x => V x + W x) hsc hsb = hamCore V hVc hVb + potCore W hWc hWb := by

  refine LinearMap.ext fun x => ?_
  obtain ⟨p, hp⟩ := x.2
  have hx : x = ⟨pgLp p, pgLp_mem_core p⟩ := Subtype.ext hp.symm
  have hsplit : potLp (fun x => V x + W x) hsc hsb p
      = potLp V hVc hVb p + potLp W hWc hWb p := by
    unfold potLp
    rw [← MemLp.toLp_add (memLp_mul_pgFun_of_expBounded hVc hVb p)
      (memLp_mul_pgFun_of_expBounded hWc hWb p)]
    refine MemLp.toLp_congr _ _ ?_
    filter_upwards with y
    simp only [Pi.add_apply]
    push_cast
    ring
  rw [hx, hamCore_pgLp, LinearMap.add_apply, hamCore_pgLp, potCore_pgLp]
  unfold hamPoly
  rw [hsplit, add_assoc]
