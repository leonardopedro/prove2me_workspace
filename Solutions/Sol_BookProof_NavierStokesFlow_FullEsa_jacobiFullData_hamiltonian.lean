-- Generated from ChapterNavierStokesFullEsa.lean — solution of BookProof.NavierStokesFlow.FullEsa.jacobiFullData_hamiltonian
import Mathlib
import Definitions.Def_ChapterNavierStokesFullEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FullEsa



open scoped ENNReal

set_option maxHeartbeats 1000000 in
theorem solution : jacobiFullData.hamiltonian = jacobiOp := by

  have hvel : ∀ j : Fin 3, jacobiFullData.velocity j = 0 := by
    intro j
    have h : nsVelIdx j ≠ nsLapIdx 0 := by
      fin_cases j <;> decide
    exact jacobiMode_of_ne h
  have hlap0 : jacobiFullData.lapVelocity 0 = ((-1 / 2 : ℝ) : ℂ) • LinearMap.id :=
    jacobiMode_lap
  have hlapne : ∀ i : Fin 3, i ≠ 0 → jacobiFullData.lapVelocity i = 0 := by
    intro i hi
    refine jacobiMode_of_ne ?_
    fin_cases i
    · exact absurd rfl hi
    · decide
    · decide
  have hsum : ∀ i : Fin 3,
      (∑ j : Fin 3, (jacobiFullData.velocity j).comp (jacobiFullData.gradVelocity i j)) = 0 := by
    intro i
    refine Finset.sum_eq_zero fun j _ => ?_
    rw [hvel j, LinearMap.zero_comp]
  have hnu : ((jacobiFullData.nu : ℝ) : ℂ) = 1 := by
    change ((1 : ℝ) : ℂ) = 1
    norm_num
  have hadv0 : jacobiFullData.advection 0 = ((1 / 2 : ℝ) : ℂ) • LinearMap.id := by
    rw [NSFullData.advection, hsum 0, hlap0, hnu, zero_sub, smul_smul, one_mul]
    norm_num
  have hadvne : ∀ i : Fin 3, i ≠ 0 → jacobiFullData.advection i = 0 := by
    intro i hi
    rw [NSFullData.advection, hsum i, hlapne i hi, smul_zero, sub_zero]
  have hmom0 : jacobiFullData.mom 0 = jacobiOp := jacobiMom_zero
  have hmomne : ∀ i : Fin 3, i ≠ 0 → jacobiFullData.mom i = 0 := fun i hi => jacobiMom_of_ne hi
  rw [NSFullData.hamiltonian, Fin.sum_univ_three, hadv0,
    hadvne 1 (by decide), hadvne 2 (by decide), hmomne 1 (by decide), hmomne 2 (by decide)]
  simp only [LinearMap.comp_zero, add_zero,
    LinearMap.comp_smul, LinearMap.smul_comp, LinearMap.comp_id, LinearMap.id_comp]
  rw [← add_smul]
  have hhalf : ((1 / 2 : ℝ) : ℂ) + ((1 / 2 : ℝ) : ℂ) = 1 := by norm_num
  rw [hhalf, one_smul]
  exact hmom0
