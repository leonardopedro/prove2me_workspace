-- Generated from ChapterSmFullEnclosure.lean — solution of BookProof.SmFullEnclosure.smFullHam_fermi_block
import Mathlib
import Definitions.Def_ChapterSmFullEnclosure
open BookProof.SmFullEnclosure




open scoped TensorProduct
open BookProof.SmHamiltonian BookProof.SmDiracYukawa BookProof.SmCar
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.HermiteProductCore
open BookProof.DirectSumEsa BookProof.SecondQuantizationCore
open BookProof.FarisLavine BookProof.TensorCore BookProof.TensorSumEsa
open BookProof.YangMillsNonAbelianEsa

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {n : ℕ} (hD M : Matrix (Fin n) (Fin n) ℂ) (z : ℂ) :
    onFull (smFermiHam hD M z) = onFull (smDirac hD + smYukawa M z) := by

  rw [smFermiHam_eq]
