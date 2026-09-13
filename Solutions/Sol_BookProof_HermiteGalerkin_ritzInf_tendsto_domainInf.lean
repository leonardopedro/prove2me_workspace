-- Generated from ChapterHermiteGalerkinFriedrichs.lean — solution of BookProof.HermiteGalerkin.ritzInf_tendsto_domainInf
import Mathlib
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Theorems.Thm_BookProof_HermiteGalerkin_galerkinSpan_mono
import Theorems.Thm_BookProof_HermiteGalerkin_basis_mem_galerkinSpan
import Theorems.Thm_BookProof_HermiteGalerkin_galerkinSpan_le_finiteModeDomain
import Theorems.Thm_BookProof_HermiteGalerkin_exists_mem_galerkinSpan
import Theorems.Thm_BookProof_HermiteGalerkin_ritzSet_mono
import Theorems.Thm_BookProof_HermiteGalerkin_ritzSet_bddBelow
import Theorems.Thm_BookProof_HermiteGalerkin_ritzInf_antitone
import Theorems.Thm_BookProof_HermiteGalerkin_ritzInf_nonneg
import Definitions.Def_ChapterYangMillsFriedrichsLimit
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterFarisLavine
open BookProof.HermiteGalerkin













open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.YangMillsFriedrichsLimit
open Filter Topology



variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]






variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]


















variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]



variable {D : Submodule ℂ F}

set_option maxHeartbeats 1000000 in
theorem solution (b : HilbertBasis ℕ ℂ F) (H : finiteModeDomain b →ₗ[ℂ] F)
    (hpos : ∀ x : finiteModeDomain b, 0 ≤ quadForm H x) :
    Tendsto (fun m : ℕ => ritzInf H (galerkinSpan b (m + 1))) atTop
      (nhds (ritzInf H (finiteModeDomain b))) := by

  set a : ℕ → ℝ := fun m => ritzInf H (galerkinSpan b (m + 1)) with ha
  -- the first basis vector is a unit vector of every truncation subspace
  have hb0mem : b 0 ∈ finiteModeDomain b := Submodule.subset_span ⟨0, rfl⟩
  have hb0norm : ‖b 0‖ = 1 := b.orthonormal.1 0
  have hne : ∀ m : ℕ, (ritzSet H (galerkinSpan b (m + 1))).Nonempty := by
    intro m
    refine ⟨quadForm H ⟨b 0, hb0mem⟩, ⟨b 0, hb0mem⟩, ?_, hb0norm, rfl⟩
    exact galerkinSpan_mono b (Nat.succ_le_succ (Nat.zero_le m))
      (basis_mem_galerkinSpan b Nat.zero_lt_one)
  have hsub : ∀ m : ℕ, ritzSet H (galerkinSpan b (m + 1)) ⊆ ritzSet H (finiteModeDomain b) :=
    fun m => ritzSet_mono H (galerkinSpan_le_finiteModeDomain b (m + 1))
  -- the sequence of Ritz values is antitone and bounded below
  have hanti : Antitone a := by
    intro p q hpq
    exact ritzInf_antitone H hpos (galerkinSpan_mono b (Nat.succ_le_succ hpq)) (hne p)
  have hnonneg : ∀ m : ℕ, 0 ≤ a m := fun m => ritzInf_nonneg H hpos _ (hne m)
  have hbdd : BddBelow (Set.range a) := ⟨0, by rintro t ⟨m, rfl⟩; exact hnonneg m⟩
  have hlim := tendsto_atTop_ciInf hanti hbdd
  -- and its limit is the infimum of the energy over the whole domain
  have hSne : (ritzSet H (finiteModeDomain b)).Nonempty := (hne 0).mono (hsub 0)
  have hkey : (⨅ m : ℕ, a m) = ritzInf H (finiteModeDomain b) := by
    refine le_antisymm ?_ ?_
    · refine le_csInf hSne ?_
      rintro t ⟨x, _, hx1, rfl⟩
      obtain ⟨m, hm⟩ := exists_mem_galerkinSpan b x.2
      have hmem : quadForm H x ∈ ritzSet H (galerkinSpan b (m + 1)) :=
        ⟨x, galerkinSpan_mono b (Nat.le_succ m) hm, hx1, rfl⟩
      refine le_trans (ciInf_le hbdd m) ?_
      exact csInf_le (ritzSet_bddBelow H hpos _) hmem
    · refine le_ciInf fun m => ?_
      exact csInf_le_csInf (ritzSet_bddBelow H hpos _) (hne m) (hsub m)
  rw [← hkey]
  exact hlim
