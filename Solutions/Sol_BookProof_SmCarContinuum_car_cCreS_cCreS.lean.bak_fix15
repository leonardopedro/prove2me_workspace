-- Generated from ChapterSmCarContinuum.lean — solution of BookProof.SmCarContinuum.car_cCreS_cCreS
import Mathlib
import Definitions.Def_ChapterSmCarContinuum
import Theorems.Thm_BookProof_QuantumGravityFock_jw_swap_erase
open BookProof.SmCarContinuum




open BookProof.QuantumGravityFock
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.LpNat
open BookProof.NavierStokesFlow.IkebeKato
open scoped ENNReal NNReal

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (f g : Ell2) (ψ : CFock) :
    cCreS f (cCreS g ψ) + cCreS g (cCreS f ψ) = 0 := by

  refine lp.ext (funext fun S => ?_)
  simp only [lp.coeFn_add, Pi.add_apply, lp.coeFn_zero, Pi.zero_apply, cCreS_apply]
  have expand : ∀ u v : Ell2,
      (∑ i ∈ S, (u : ℕ → ℂ) i * (jwSign i S *
          ∑ j ∈ S.erase i, (v : ℕ → ℂ) j * (jwSign j (S.erase i) * ψ ((S.erase i).erase j))))
        = ∑ i ∈ S, ∑ j ∈ S.erase i,
            (u : ℕ → ℂ) i * jwSign i S * ((v : ℕ → ℂ) j * jwSign j (S.erase i))
              * ψ ((S.erase i).erase j) := by
    intro u v
    refine Finset.sum_congr rfl fun i _ => ?_
    rw [Finset.mul_sum, Finset.mul_sum]
    exact Finset.sum_congr rfl fun j _ => by ring
  rw [expand f g, expand g f]
  rw [Finset.sum_comm' (s := S) (t := fun i => S.erase i) (t' := S) (s' := fun j => S.erase j)
    (fun x y => by
      constructor
      · rintro ⟨hx, hy⟩
        exact ⟨Finset.mem_erase.mpr ⟨fun h => (Finset.mem_erase.mp hy).1 h.symm, hx⟩,
          (Finset.mem_erase.mp hy).2⟩
      · rintro ⟨hx, hy⟩
        exact ⟨(Finset.mem_erase.mp hx).2,
          Finset.mem_erase.mpr ⟨fun h => (Finset.mem_erase.mp hx).1 h.symm, hy⟩⟩)]
  rw [← Finset.sum_add_distrib]
  refine Finset.sum_eq_zero fun i hi => ?_
  rw [← Finset.sum_add_distrib]
  refine Finset.sum_eq_zero fun j hj => ?_
  have hji : j ≠ i := (Finset.mem_erase.mp hj).1
  have hjS : j ∈ S := (Finset.mem_erase.mp hj).2
  have hsign : jwSign j S * jwSign i (S.erase j) = -(jwSign i S * jwSign j (S.erase i)) :=
    jw_swap_erase hji hjS hi
  rw [(Finset.erase_right_comm : (S.erase j).erase i = (S.erase i).erase j)]
  have hkey : (f : ℕ → ℂ) j * jwSign j S * ((g : ℕ → ℂ) i * jwSign i (S.erase j))
      = - ((g : ℕ → ℂ) i * jwSign i S * ((f : ℕ → ℂ) j * jwSign j (S.erase i))) := by
    calc (f : ℕ → ℂ) j * jwSign j S * ((g : ℕ → ℂ) i * jwSign i (S.erase j))
        = ((f : ℕ → ℂ) j * (g : ℕ → ℂ) i) * (jwSign j S * jwSign i (S.erase j)) := by ring
      _ = ((f : ℕ → ℂ) j * (g : ℕ → ℂ) i) * (-(jwSign i S * jwSign j (S.erase i))) := by
            rw [hsign]
      _ = - ((g : ℕ → ℂ) i * jwSign i S * ((f : ℕ → ℂ) j * jwSign j (S.erase i))) := by ring
  rw [hkey]
  ring
