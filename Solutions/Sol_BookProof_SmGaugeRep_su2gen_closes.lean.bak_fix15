-- Generated from ChapterSmGaugeRepresentation.lean — solution of BookProof.SmGaugeRep.su2gen_closes
import Mathlib
import Definitions.Def_ChapterSmGaugeRepresentation
open BookProof.SmGaugeRep




open Matrix Kronecker
open BookProof.YangMillsSU3 BookProof.SmBrstGhost

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution : ClosesWithStructureConstants su2gen su2Struct := by

  intro a b
  fin_cases a <;> fin_cases b <;>
    (rw [Fin.sum_univ_three]
     ext i j
     fin_cases i <;> fin_cases j <;>
       norm_num +decide [su2gen, pauli, su2Struct, epsZ, Matrix.mul_apply, Fin.sum_univ_two,
         Matrix.one_apply, Complex.ext_iff, Matrix.smul_apply, Matrix.cons_val_two,
         Matrix.tail_cons, Matrix.head_cons])
