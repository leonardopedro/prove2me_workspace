-- Generated from ChapterSmYukawaCoupling.lean — solution of BookProof.SmYukawaCoupling.higgs_sq_le
import Mathlib
import Definitions.Def_ChapterSmYukawaCoupling
open BookProof.SmYukawaCoupling




open scoped TensorProduct
open MeasureTheory MvPolynomial
open BookProof.SmHamiltonian BookProof.SmDiracYukawa BookProof.SmCar BookProof.SmOneParticle
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.HermiteProductCore
open BookProof.DirectSumEsa BookProof.SecondQuantizationCore
open BookProof.FarisLavine BookProof.TensorCore BookProof.TensorSumEsa
open BookProof.YangMillsNonAbelianEsa BookProof.SmFullEnclosure BookProof.TensorKatoRellich

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (P : SmParams) (hlam : 0 < P.lam) (x : Vd 163) (a : Fin 4) :
    x (smPhi a) ^ 2 ≤ 2 / P.lam * wallVal P x ^ 2 + (P.vev ^ 2 + 1 / 4) := by

  have hr : x (smPhi a) ^ 2 ≤ ∑ b : Fin 4, x (smPhi b) ^ 2 :=
    Finset.single_le_sum (f := fun b => x (smPhi b) ^ 2) (fun b _ => sq_nonneg _)
      (Finset.mem_univ a)
  have hW : 2 / P.lam * wallVal P x ^ 2
      = ((∑ b : Fin 4, x (smPhi b) ^ 2) - P.vev ^ 2) ^ 2 := by
    rw [wallVal, mul_pow, Real.sq_sqrt (by positivity)]
    field_simp
  rw [hW]
  nlinarith [sq_nonneg ((∑ b : Fin 4, x (smPhi b) ^ 2) - P.vev ^ 2 - 1 / 2)]
