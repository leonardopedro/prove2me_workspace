-- Generated from ChapterSmCarContinuum.lean — solution of BookProof.SmCarContinuum.cCreS_eq_cCreFin
import Mathlib
import Definitions.Def_ChapterSmCarContinuum
import Definitions.Def_ChapterQuantumGravityFock
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesDeficiency
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterRieszFischer
import Definitions.Def_ChapterSmCarAlgebra
open BookProof.SmCarContinuum




open BookProof.QuantumGravityFock
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.LpNat
open BookProof.NavierStokesFlow.IkebeKato
open scoped ENNReal NNReal
open BookProof.ChapterRieszFischer
open BookProof.SmCar

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {f : Ell2} {J : Finset ℕ} (h : ∀ i, (f : ℕ → ℂ) i ≠ 0 → i ∈ J) :
    cCreS f = cCreFin J (fun i => f i) := by

  refine ContinuousLinearMap.ext fun ψ => lp.ext (funext fun S => ?_)
  rw [cCreS_apply, cCreFin_apply, Finset.sum_ite_mem]
  refine (Finset.sum_subset Finset.inter_subset_right ?_).symm
  intro i hiS hi
  have hz : (f : ℕ → ℂ) i = 0 := by
    by_contra hne
    exact hi (Finset.mem_inter.mpr ⟨h i hne, hiS⟩)
  rw [hz, zero_mul]
