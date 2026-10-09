-- Generated from ChapterYangMillsNonAbelianEsa.lean — solution of BookProof.YangMillsNonAbelianEsa.weylPoly_eq_hamCoreS
import Mathlib
import Definitions.Def_ChapterYangMillsNonAbelianEsa
import Theorems.Thm_BookProof_YangMillsNonAbelianEsa_op_pgLp_d
import Theorems.Thm_BookProof_YangMillsNonAbelianEsa_realCoeff_weylPotPoly
import Theorems.Thm_BookProof_YangMillsNonAbelianEsa_sum_momOp_eq_kinPolyS
import Theorems.Thm_BookProof_DegSchrodinger_continuous_polyW
import Theorems.Thm_BookProof_DegSchrodinger_expBounded_polyW
import Theorems.Thm_BookProof_DegSchrodinger_hamCoreS_pgLp
import Theorems.Thm_BookProof_HermiteGraphApprox_potLp_polyW_eq
import Theorems.Thm_BookProof_HermiteProductCore_pgMap_apply
import Theorems.Thm_BookProof_YangMillsFriedrichs_weylOp_apply
import Theorems.Thm_BookProof_YangMillsHermite_mulOp_apply
open BookProof.YangMillsNonAbelianEsa




open MeasureTheory MvPolynomial
open BookProof.FarisLavine BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgOneParticleCc BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.DegSchrodinger BookProof.DegKatoEsa BookProof.HermiteGraphApprox
open BookProof.TensorCore BookProof.DirectSumEsa BookProof.SecondQuantizationCore

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {D : Submodule ℂ F}
variable {d : ℕ}
variable {d k r : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {idx : Fin k → Fin d} (hidx : Function.Injective idx)
    {Φ : Fin r → MvPolynomial (Fin d) ℂ} (hΦ : ∀ j, RealCoeff (Φ j)) :
    weylPoly idx Φ
      = (((1 / 2 : ℝ)) : ℂ) • hamCoreS (polyW (weylPotPoly Φ)) (continuous_polyW _)
          (expBounded_polyW _) (Finset.image idx Finset.univ)
        + (((-1 / 2 : ℝ)) : ℂ) • (polyGaussCore (d := d)).subtype := by

  refine LinearMap.ext fun x => ?_
  obtain ⟨p, hp⟩ := x.2
  have hx : x = ⟨pgLp p, pgLp_mem_core p⟩ := Subtype.ext hp.symm
  subst hx
  have hpgsum : ∀ (n : ℕ) (f : Fin n → MvPolynomial (Fin d) ℂ),
      (∑ i : Fin n, pgLp (f i)) = pgLp (∑ i : Fin n, f i) := by
    intro n f
    rw [← HermiteProductCore.pgMap_apply, map_sum]
    rfl
  have hmap : ∀ q : MvPolynomial (Fin d) ℂ, pgLp q = pgMap (d := d) q := fun _ => rfl
  have hlhs : weylPoly idx Φ ⟨pgLp p, pgLp_mem_core p⟩
      = pgLp (((1 / 2 : ℝ) : ℂ) • ((∑ m : Fin k, momOp (idx m) (momOp (idx m) p))
          + ∑ j : Fin r, Φ j * (Φ j * p))) := by
    have hpi : ∀ m : Fin k,
        (((coreRepPoly d).op (momOp (idx m)) ((coreRepPoly d).op (momOp (idx m))
            ⟨pgLp p, pgLp_mem_core p⟩) : polyGaussCore (d := d)) : L2d d)
          = pgLp (momOp (idx m) (momOp (idx m) p)) := by
      intro m
      rw [op_pgLp_d, op_pgLp_d]
    have hmag : ∀ j : Fin r,
        (((coreRepPoly d).op (mulOp (Φ j)) ((coreRepPoly d).op (mulOp (Φ j))
            ⟨pgLp p, pgLp_mem_core p⟩) : polyGaussCore (d := d)) : L2d d)
          = pgLp (Φ j * (Φ j * p)) := by
      intro j
      rw [op_pgLp_d, op_pgLp_d, mulOp_apply, mulOp_apply]
    rw [weylPoly, weylOp_apply, Finset.sum_congr rfl fun m _ => hpi m,
      Finset.sum_congr rfl fun j _ => hmag j, hpgsum, hpgsum]
    simp only [hmap, ← map_smul, ← map_add]
  have hrhs : ((((1 / 2 : ℝ)) : ℂ) • hamCoreS (polyW (weylPotPoly Φ)) (continuous_polyW _)
          (expBounded_polyW _) (Finset.image idx Finset.univ)
        + (((-1 / 2 : ℝ)) : ℂ) • (polyGaussCore (d := d)).subtype)
        ⟨pgLp p, pgLp_mem_core p⟩
      = pgLp (((1 / 2 : ℝ) : ℂ) • (kinPolyS (Finset.image idx Finset.univ) p
          + weylPotPoly Φ * p) + ((-1 / 2 : ℝ) : ℂ) • p) := by
    rw [LinearMap.add_apply, LinearMap.smul_apply, LinearMap.smul_apply, hamCoreS_pgLp,
      hamPolyS, potLp_polyW_eq (realCoeff_weylPotPoly hΦ), Submodule.subtype_apply]
    have hcoe : ((⟨pgLp p, pgLp_mem_core p⟩ : polyGaussCore (d := d)) : L2d d) = pgLp p := rfl
    rw [hcoe]
    simp only [hmap, ← map_smul, ← map_add]
  rw [hlhs, hrhs]
  congr 1
  rw [sum_momOp_eq_kinPolyS hidx, weylPotPoly]
  simp only [add_mul, Finset.sum_mul, mul_assoc]
  rw [MvPolynomial.smul_eq_C_mul, MvPolynomial.smul_eq_C_mul, MvPolynomial.smul_eq_C_mul]
  have hneg : (C (((-1 / 2 : ℝ)) : ℂ) : MvPolynomial (Fin d) ℂ) = -C (((1 / 2 : ℝ)) : ℂ) := by
    rw [← map_neg]
    congr 1
    push_cast
    ring
  rw [hneg, Complex.ofReal_one, map_one]
  ring
