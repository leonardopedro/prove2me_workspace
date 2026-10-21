-- Generated from ChapterFockSchurEsa.lean — solution of BookProof.FockSchur.dGammaOp_commForm_zero
import Mathlib
import Definitions.Def_ChapterFockSchurEsa
import Theorems.Thm_BookProof_FockSchur_dGamma_inSector
import Theorems.Thm_BookProof_FockSchur_inner_toLp_eq_zero_of_ne_sector
import Theorems.Thm_BookProof_FockSchur_sectorPart_inSector
import Theorems.Thm_BookProof_FockSchur_sectorPart_apply
import Theorems.Thm_BookProof_FockSchur_sum_sectorPart
import Theorems.Thm_BookProof_FockSchur_numWeight_apply
import Theorems.Thm_BookProof_FockSchur_diagMax_numSym_eq
import Theorems.Thm_BookProof_FockSecondQuantization_coe_dGammaOp
import Theorems.Thm_BookProof_FockSecondQuantization_inner_dGamma_symm
import Theorems.Thm_BookProof_FockSecondQuantization_toLpL_apply
open BookProof.FockSchur




open BookProof.FockSecondQuantization BookProof.CoreBounds
open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.YangMillsFriedrichs

noncomputable section

variable {col : ℕ → (ℕ →₀ ℂ)} {K : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (hherm : IsHermCol col) (x : lpFiniteModes Conf) :
    (inner ℂ (dGammaOp col x) ((diagMax numSym (inclC numSym x) : Fock)) : ℂ).im = 0 := by

  classical
  set w : FockAlg := fockEquiv.symm x with hw
  rw [coe_dGammaOp col x, diagMax_numSym_eq x]
  set D : Finset ℕ := w.support.image ndeg with hD
  have hnum : numWeight w = ∑ n ∈ D, ((n : ℂ) + 1) • sectorPart n w := by
    refine Finsupp.ext fun α => ?_
    rw [numWeight_apply, Finset.sum_apply']
    have hterm : ∀ n ∈ D, (((n : ℂ) + 1) • sectorPart n w) α
        = if ndeg α = n then ((ndeg α : ℂ) + 1) * w α else 0 := by
      intro n _
      rw [Finsupp.smul_apply, sectorPart_apply, smul_eq_mul]
      by_cases h : ndeg α = n
      · rw [if_pos h, if_pos h, h]
      · rw [if_neg h, if_neg h, mul_zero]
    rw [Finset.sum_congr rfl hterm, Finset.sum_ite_eq]
    by_cases hα : α ∈ w.support
    · rw [if_pos (Finset.mem_image_of_mem ndeg hα)]
      simp only [numSym]
      push_cast
      ring
    · rw [Finsupp.notMem_support_iff.mp hα]
      simp
  have hXsum : toLp (dGamma col w) = ∑ n ∈ D, toLp (dGamma col (sectorPart n w)) := by
    conv_lhs => rw [← sum_sectorPart w]
    rw [map_sum, ← toLpL_apply, map_sum]
    rfl
  have hNsum : toLp (numWeight w) = ∑ n ∈ D, ((n : ℂ) + 1) • toLp (sectorPart n w) := by
    rw [hnum, ← toLpL_apply, map_sum]
    exact Finset.sum_congr rfl fun n _ => by rw [map_smul, toLpL_apply]
  rw [hXsum, hNsum, sum_inner]
  have hterm : ∀ n ∈ D, (inner ℂ (toLp (dGamma col (sectorPart n w)))
        (∑ m ∈ D, ((m : ℂ) + 1) • toLp (sectorPart m w)) : ℂ)
      = ((n : ℂ) + 1)
        * inner ℂ (toLp (dGamma col (sectorPart n w))) (toLp (sectorPart n w)) := by
    intro n hn
    rw [inner_sum, Finset.sum_eq_single n]
    · rw [inner_smul_right]
    · intro m hm hmn
      rw [inner_smul_right,
        inner_toLp_eq_zero_of_ne_sector (dGamma_inSector col (sectorPart_inSector n w))
          (sectorPart_inSector m w) (Ne.symm hmn), mul_zero]
    · intro hcon
      exact absurd hn hcon
  rw [Finset.sum_congr rfl hterm, Complex.im_sum]
  refine Finset.sum_eq_zero fun n _ => ?_
  have hre : (inner ℂ (toLp (dGamma col (sectorPart n w))) (toLp (sectorPart n w)) : ℂ).im
      = 0 := by
    have hsymm := inner_dGamma_symm hherm (sectorPart n w) (sectorPart n w)
    have hconj := inner_conj_symm (𝕜 := ℂ) (toLp (sectorPart n w))
      (toLp (dGamma col (sectorPart n w)))
    have hz : (starRingEnd ℂ) (inner ℂ (toLp (dGamma col (sectorPart n w)))
        (toLp (sectorPart n w)) : ℂ)
        = inner ℂ (toLp (dGamma col (sectorPart n w))) (toLp (sectorPart n w)) := by
      rw [hconj, ← hsymm]
    exact Complex.conj_eq_iff_im.mp hz
  simp [Complex.mul_im, hre]
