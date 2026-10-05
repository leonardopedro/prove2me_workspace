-- Generated from ChapterSmComparisonEsa.lean — solution of BookProof.SmComparisonEsa.smFlN_eq_hamCoreS
import Mathlib
import Definitions.Def_ChapterSmComparisonEsa
import Theorems.Thm_BookProof_SmComparisonEsa_op_pgLp
import Theorems.Thm_BookProof_SmComparisonEsa_realCoeff_smPotPoly
import Theorems.Thm_BookProof_SmComparisonEsa_potLp_polyW
import Theorems.Thm_BookProof_SmComparisonEsa_sum_momOp_eq_kinPolyS
import Theorems.Thm_BookProof_DegSchrodinger_continuous_polyW
import Theorems.Thm_BookProof_DegSchrodinger_expBounded_polyW
import Theorems.Thm_BookProof_DegSchrodinger_hamCoreS_pgLp
import Theorems.Thm_BookProof_HermiteProductCore_pgMap_apply
import Theorems.Thm_BookProof_YangMillsFriedrichs_weylOp_apply
open BookProof.SmComparisonEsa




open MeasureTheory MvPolynomial
open BookProof.FarisLavine BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgOneParticleCc BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.DegSchrodinger BookProof.DegKatoEsa BookProof.HermiteGraphApprox
open BookProof.SmOneParticle BookProof.SmHamiltonian BookProof.SmFarisLavine

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (P : SmParams) (c0 : ℝ) :
    smFlN P c0
      = hamCoreS (polyW (smPotPoly P c0)) (continuous_polyW _) (expBounded_polyW _) smS := by

  refine LinearMap.ext fun x => ?_
  obtain ⟨p, hp⟩ := x.2
  have hx : x = ⟨pgLp p, pgLp_mem_core p⟩ := Subtype.ext hp.symm
  subst hx
  -- the two sides, written as `pgLp` of a polynomial
  have hpi : ∀ m : Fin 40,
      ((smPi m (smPi m ⟨pgLp p, pgLp_mem_core p⟩) : polyGaussCore (d := 163)) : L2d 163)
        = pgLp (momOp (smCoord m) (momOp (smCoord m) p)) := by
    intro m
    have h1 : smPi m ⟨pgLp p, pgLp_mem_core p⟩
        = ⟨pgLp (momOp (smCoord m) p), pgLp_mem_core _⟩ := by
      rw [show smPi m = (coreRepPoly 163).op (momOp (smCoord m)) from rfl, op_pgLp]
    rw [h1, show smPi m = (coreRepPoly 163).op (momOp (smCoord m)) from rfl, op_pgLp]
  have hfield : ∀ r : Fin 49,
      ((smField P r (smField P r ⟨pgLp p, pgLp_mem_core p⟩) : polyGaussCore (d := 163))
          : L2d 163)
        = pgLp (smPhi P r * (smPhi P r * p)) := by
    intro r
    have hop : smField P r = (coreRepPoly 163).op (mulOp (smPhi P r)) := rfl
    have h1 : smField P r ⟨pgLp p, pgLp_mem_core p⟩
        = ⟨pgLp (smPhi P r * p), pgLp_mem_core _⟩ := by
      rw [hop, op_pgLp]
      rfl
    rw [h1, hop, op_pgLp]
    rfl
  have hQ : smQL ⟨pgLp p, pgLp_mem_core p⟩ = pgLp (smQPoly * p) := by
    rw [smQL_apply, show smQOp = (coreRepPoly 163).op (mulOp smQPoly) from rfl, op_pgLp]
    rfl
  have hH : smHamiltonian P ⟨pgLp p, pgLp_mem_core p⟩
      = ((1 / 2 : ℝ) : ℂ) • ((∑ m : Fin 40, pgLp (momOp (smCoord m) (momOp (smCoord m) p)))
          + ∑ r : Fin 49, pgLp (smPhi P r * (smPhi P r * p))) := by
    rw [smHamiltonian, weylOp_apply]
    have h1 : (∑ i : Fin 40,
          ((smPi i) ((smPi i) ⟨pgLp p, pgLp_mem_core p⟩) : L2d 163))
        = ∑ m : Fin 40, pgLp (momOp (smCoord m) (momOp (smCoord m) p)) :=
      Finset.sum_congr rfl fun m _ => hpi m
    have h2 : (∑ a : Fin 49,
          ((smField P a) ((smField P a) ⟨pgLp p, pgLp_mem_core p⟩) : L2d 163))
        = ∑ r : Fin 49, pgLp (smPhi P r * (smPhi P r * p)) :=
      Finset.sum_congr rfl fun r _ => hfield r
    rw [h1, h2]
  -- collect the left-hand side
  have hpgsum : ∀ (n : ℕ) (f : Fin n → MvPolynomial (Fin 163) ℂ),
      (∑ i : Fin n, pgLp (f i)) = pgLp (∑ i : Fin n, f i) := by
    intro n f
    rw [← HermiteProductCore.pgMap_apply, map_sum]
    rfl
  have hlhs : smFlN P c0 ⟨pgLp p, pgLp_mem_core p⟩
      = pgLp ((∑ m : Fin 40, momOp (smCoord m) (momOp (smCoord m) p))
          + (∑ r : Fin 49, smPhi P r * (smPhi P r * p)) + smQPoly * p
          + ((c0 : ℝ) : ℂ) • p) := by
    rw [smFlN_apply, hH, hQ]
    have hcoe : ((⟨pgLp p, pgLp_mem_core p⟩ : polyGaussCore (d := 163)) : L2d 163) = pgLp p := rfl
    rw [hcoe, hpgsum, hpgsum]
    have hmap : ∀ r : MvPolynomial (Fin 163) ℂ, pgLp r = pgMap (d := 163) r := fun _ => rfl
    simp only [hmap, ← map_smul, ← map_add]
    congr 1
    push_cast
    module
  -- collect the right-hand side
  have hrhs : hamCoreS (polyW (smPotPoly P c0)) (continuous_polyW _) (expBounded_polyW _) smS
        ⟨pgLp p, pgLp_mem_core p⟩
      = pgLp (kinPolyS smS p + smPotPoly P c0 * p) := by
    rw [hamCoreS_pgLp, hamPolyS, potLp_polyW (realCoeff_smPotPoly P c0)]
    rw [← HermiteProductCore.pgMap_apply, ← HermiteProductCore.pgMap_apply, ← map_add]
    rfl
  rw [hlhs, hrhs]
  congr 1
  rw [← sum_momOp_eq_kinPolyS, smPotPoly]
  simp only [add_mul, Finset.sum_mul, mul_assoc]
  rw [MvPolynomial.smul_eq_C_mul]
  ring
