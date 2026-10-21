-- Generated from ChapterQuadratureEsa.lean — solution of BookProof.QuadratureEsa.phaseU_foOp_hermiteCore
import Mathlib
import Definitions.Def_ChapterQuadratureEsa
import Theorems.Thm_BookProof_QuadratureEsa_foOp_hermiteCore
import Theorems.Thm_BookProof_QuadratureEsa_foAmp_real
import Theorems.Thm_BookProof_QuadratureEsa_norm_foPhase
import Theorems.Thm_BookProof_QuadratureEsa_foMod_mul_foPhase
import Theorems.Thm_BookProof_QuadratureEsa_foMod_eq_conj_mul_foPhase
import Theorems.Thm_BookProof_QuadratureEsa_phasePow_add_single
import Theorems.Thm_BookProof_QuadratureEsa_phasePow_sub_single
open BookProof.QuadratureEsa




open MeasureTheory MvPolynomial FourierTransform
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.YangMillsHermite
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (b b' : Fin d → ℝ) (a : Fin d →₀ ℕ) :
    phaseU (foPhase b b') (norm_foPhase b b') (foOp (foMod b b') 0 (hermiteCore a))
      = foOp b b' (phaseCore (foPhase b b') (norm_foPhase b b') (hermiteCore a)) := by

  classical
  have hpc : phaseCore (foPhase b b') (norm_foPhase b b') (hermiteCore a)
      = phasePow (foPhase b b') a • hermiteCore a := by
    refine Subtype.ext ?_
    rw [phaseCore_coe, hermiteCore_coe, phaseU_hermiteMvLp, Submodule.coe_smul, hermiteCore_coe]
  rw [hpc, map_smul, foOp_hermiteCore, foOp_hermiteCore, map_sum, Finset.smul_sum]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [map_add, map_smul, map_smul, phaseU_hermiteMvLp, phaseU_hermiteMvLp, smul_add,
    smul_smul, smul_smul, smul_smul, smul_smul, foAmp_real, Complex.conj_ofReal]
  have hup : ((foMod b b' i : ℝ) : ℂ) * ((Real.sqrt ((a i : ℝ) + 1) : ℝ) : ℂ)
      * phasePow (foPhase b b') (a + Finsupp.single i 1)
      = phasePow (foPhase b b') a * (foAmp b b' i * ((Real.sqrt ((a i : ℝ) + 1) : ℝ) : ℂ)) := by
    rw [phasePow_add_single, ← foMod_mul_foPhase b b' i]
    ring
  have hdown : ((foMod b b' i : ℝ) : ℂ) * ((Real.sqrt ((a i : ℝ)) : ℝ) : ℂ)
      * phasePow (foPhase b b') (a - Finsupp.single i 1)
      = phasePow (foPhase b b') a
        * ((starRingEnd ℂ) (foAmp b b' i) * ((Real.sqrt ((a i : ℝ)) : ℝ) : ℂ)) := by
    rcases Nat.eq_zero_or_pos (a i) with h0 | hpos
    · have hs : ((Real.sqrt ((a i : ℝ)) : ℝ) : ℂ) = 0 := by
        rw [h0]
        simp
      rw [hs]
      ring
    · rw [← phasePow_sub_single (foPhase b b') hpos]
      rw [foMod_eq_conj_mul_foPhase b b' i]
      ring
  rw [hup, hdown]
