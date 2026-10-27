-- Generated from ChapterSmFullEnclosure.lean — solution of BookProof.SmFullEnclosure.smFermiHam_esa
import Mathlib
import Definitions.Def_ChapterSmFullEnclosure
import Theorems.Thm_BookProof_SmDiracYukawa_sm_fermi_esa
open BookProof.SmFullEnclosure




open scoped TensorProduct
open BookProof.SmHamiltonian BookProof.SmDiracYukawa BookProof.SmCar
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.HermiteProductCore
open BookProof.DirectSumEsa BookProof.SecondQuantizationCore
open BookProof.FarisLavine BookProof.TensorCore BookProof.TensorSumEsa
open BookProof.YangMillsNonAbelianEsa

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {n : ℕ} {hD : Matrix (Fin n) (Fin n) ℂ}
    (M : Matrix (Fin n) (Fin n) ℂ) (z : ℂ) (hh : hD.conjTranspose = hD) :
    EssentiallySelfAdjointOn (fullDom n) (onFull (smFermiHam hD M z)) := sm_fermi_esa (M := M) (z := z) (om := fun _ => 0) (c0 := 1) hh (fun _ => le_rfl) le_rfl
