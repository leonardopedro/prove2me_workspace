-- Generated from ChapterYangMillsAbelianEsa.lean — solution of BookProof.YangMillsAbelianEsa.ymAbelianPoly_eq_fqPoly
import Mathlib
import Definitions.Def_ChapterYangMillsAbelianEsa
import Theorems.Thm_BookProof_YangMillsAbelianEsa_gramWeyl_eq
import Theorems.Thm_BookProof_YangMillsAbelianEsa_sum_ymMomVec_mom
import Theorems.Thm_BookProof_YangMillsAbelianEsa_sum_ymMagVec_mulX
import Theorems.Thm_BookProof_YangMillsAbelianEsa_ymAbelianPoly_apply
import Theorems.Thm_BookProof_HermiteRelative_momPoly_eq_ymMomOp
open BookProof.YangMillsAbelianEsa




open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.FullQuadratic
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.HashimotoShiftInvert BookProof.HermiteGalerkin BookProof.YangMillsFriedrichs

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution : ymAbelianPoly = fqPoly ymFqP ymFqQ 0 0 0 := by

  refine LinearMap.ext fun p => ?_
  have hfo : foPoly (d := 99) 0 0 p = 0 := by simp [foPoly]
  have hmom : ∑ i : Fin 99, ∑ j : Fin 99,
      ((ymFqP i j : ℝ) : ℂ) • weylProd (momPoly i) (momPoly j) p
        = ((1 / 2 : ℝ) : ℂ) • ∑ m : Fin 24,
            YangMillsHermite.momOp (ymMomIdx m) (YangMillsHermite.momOp (ymMomIdx m) p) := by
    have hstep : ∑ i : Fin 99, ∑ j : Fin 99,
        ((ymFqP i j : ℝ) : ℂ) • weylProd (momPoly i) (momPoly j) p
          = ∑ i : Fin 99, ∑ j : Fin 99,
            ((((1 / 2 : ℝ) * ∑ m : Fin 24, ymMomVec m i * ymMomVec m j : ℝ)) : ℂ)
              • weylProd ((fun i => momPoly i) i) ((fun i => momPoly i) j) p :=
      Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => by rw [ymFqP]
    rw [hstep, gramWeyl_eq ymMomVec (fun i => momPoly i) p]
    refine congrArg (fun z => ((1 / 2 : ℝ) : ℂ) • z) ?_
    refine Finset.sum_congr rfl fun m _ => ?_
    rw [sum_ymMomVec_mom m, momPoly_eq_ymMomOp]
  have hmul : ∑ i : Fin 99, ∑ j : Fin 99,
      ((ymFqQ i j : ℝ) : ℂ) • weylProd (mulXPoly i) (mulXPoly j) p
        = ((1 / 2 : ℝ) : ℂ) • ∑ m : Fin 24,
            mulOp (magPoly 0 (decodeSpace m) (decodeColor m))
              (mulOp (magPoly 0 (decodeSpace m) (decodeColor m)) p) := by
    have hstep : ∑ i : Fin 99, ∑ j : Fin 99,
        ((ymFqQ i j : ℝ) : ℂ) • weylProd (mulXPoly i) (mulXPoly j) p
          = ∑ i : Fin 99, ∑ j : Fin 99,
            ((((1 / 2 : ℝ) * ∑ m : Fin 24, ymMagVec m i * ymMagVec m j : ℝ)) : ℂ)
              • weylProd ((fun i => mulXPoly i) i) ((fun i => mulXPoly i) j) p :=
      Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => by rw [ymFqQ]
    rw [hstep, gramWeyl_eq ymMagVec (fun i => mulXPoly i) p]
    refine congrArg (fun z => ((1 / 2 : ℝ) : ℂ) • z) ?_
    refine Finset.sum_congr rfl fun m _ => ?_
    rw [sum_ymMagVec_mulX m]
  have hfq : fqPoly ymFqP ymFqQ 0 0 0 p
      = (∑ i : Fin 99, ∑ j : Fin 99,
          ((ymFqP i j : ℝ) : ℂ) • weylProd (momPoly i) (momPoly j) p)
        + ∑ i : Fin 99, ∑ j : Fin 99,
            ((ymFqQ i j : ℝ) : ℂ) • weylProd (mulXPoly i) (mulXPoly j) p := by
    rw [fqPoly, fqQuadPoly]
    simp only [LinearMap.add_apply, LinearMap.sum_apply, LinearMap.smul_apply, Pi.zero_apply,
      Complex.ofReal_zero, zero_smul, add_zero, hfo]
    rw [← Finset.sum_add_distrib]
    exact Finset.sum_congr rfl fun i _ => Finset.sum_add_distrib
  rw [ymAbelianPoly_apply, hfq, hmom, hmul, smul_add]
