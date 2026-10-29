-- Generated from ChapterSmCarAlgebra.lean — solution of BookProof.SmCar.car_creat_creat
import Mathlib
import Definitions.Def_ChapterSmCarAlgebra
import Theorems.Thm_BookProof_SmCar_jwSign_insert
import Definitions.Def_ChapterNavierStokesFockSpace
open BookProof.SmCar




open Finset
open BookProof.NavierStokesFlow.FockOfFock

variable {n : ℕ}

variable {n : ℕ}

/-- Local unfolding of `creat` — the published bundle ships only the `def`. -/
theorem creat_eq (i : Fin n) (ψ : FermiFock n) (S : Finset (Fin n)) :
    (creat i ψ).ofLp S = if i ∈ S then jwSign i (S.erase i) * ψ.ofLp (S.erase i) else 0 := rfl

set_option maxHeartbeats 1000000 in

theorem solution (i j : Fin n) :
    BookProof.SmCar.creat i ∘ₗ creat j + BookProof.SmCar.creat j ∘ₗ creat i = 0 := by
  refine LinearMap.ext fun ψ => ?_
  ext S
  rcases eq_or_ne i j with rfl | hij
  · by_cases h : i ∈ S
    · simp [h, creat_eq]
    · simp [h, creat_eq]
  · by_cases hi : i ∈ S
    · by_cases hj : j ∈ S
      · -- both occupied: the two terms cancel
        have hjR : j ∈ S.erase i := Finset.mem_erase.mpr ⟨hij.symm, hj⟩
        have hiR : i ∈ S.erase j := Finset.mem_erase.mpr ⟨hij, hi⟩
        set R : Finset (Fin n) := (S.erase i).erase j with hR
        have hRij : (S.erase j).erase i = R := by
          rw [hR, Finset.erase_right_comm]
        have hjnotR : j ∉ R := by
          rw [hR]; exact Finset.notMem_erase _ _
        have hinotR : i ∉ R := by
          rw [hR, Finset.erase_right_comm]; exact Finset.notMem_erase _ _
        have hSi : S.erase i = insert j R := by
          rw [hR, Finset.insert_erase hjR]
        have hSj : S.erase j = insert i R := by
          rw [← hRij, Finset.insert_erase hiR]
        have hsign1 : jwSign i (S.erase i) = (if j < i then -1 else 1) * jwSign i R := by
          rw [hSi]; exact jwSign_insert hjnotR
        have hsign2 : jwSign j (S.erase j) = (if i < j then -1 else 1) * jwSign j R := by
          rw [hSj]; exact jwSign_insert hinotR
        have hne : i < j ∨ j < i := lt_or_gt_of_ne hij
        simp only [LinearMap.add_apply, LinearMap.comp_apply, LinearMap.zero_apply,
          PiLp.add_apply, PiLp.zero_apply, creat_eq, if_pos hi, if_pos hj, if_pos hjR,
          if_pos hiR, hRij, hsign1, hsign2]
        rcases hne with hlt1 | hlt2
        · rw [if_pos hlt1, if_neg (asymm hlt1)]
          ring
        · rw [if_neg (asymm hlt2), if_pos hlt2]
          ring
      · have hjR : j ∉ S.erase i := fun hmem => hj (Finset.mem_of_mem_erase hmem)
        simp [hi, hj, hjR, creat_eq]
    · by_cases hj : j ∈ S
      · have hiR : i ∉ S.erase j := fun hmem => hi (Finset.mem_of_mem_erase hmem)
        simp [hi, hj, hiR, creat_eq]
      · simp [hi, hj, creat_eq]
