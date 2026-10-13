-- Generated from ChapterSmYukawaCoupling.lean — solution of BookProof.SmYukawaCoupling.eval_smWall
import Mathlib
import Definitions.Def_ChapterSmYukawaCoupling
import Definitions.Def_ChapterSmDiracYukawa
import Definitions.Def_ChapterSmCarAlgebra
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterSecondQuantizationCoreEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterTensorSumEsa
import Definitions.Def_ChapterYangMillsNonAbelianEsa
import Definitions.Def_ChapterSmFullEnclosure
import Definitions.Def_ChapterTensorKatoRellich
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterSmHamiltonian
import Definitions.Def_ChapterSmOneParticle
open BookProof.SmYukawaCoupling




open scoped TensorProduct
open MeasureTheory MvPolynomial
open BookProof.SmHamiltonian BookProof.SmDiracYukawa BookProof.SmCar BookProof.SmOneParticle
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.HermiteProductCore
open BookProof.DirectSumEsa BookProof.SecondQuantizationCore
open BookProof.FarisLavine BookProof.TensorCore BookProof.TensorSumEsa
open BookProof.YangMillsNonAbelianEsa BookProof.SmFullEnclosure BookProof.TensorKatoRellich
open BookProof.HermiteProductCore
open BookProof.SmHamiltonian
open BookProof.SmOneParticle

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (P : SmParams) (x : Vd 163) :
    MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) (smWall P (id : Fin 163 → Fin 163))
      = ((wallVal P x : ℝ) : ℂ) := by

  rw [smWall, MvPolynomial.smul_eq_C_mul]
  simp only [map_mul, map_sub, map_sum, eval_X, eval_C, id, wallVal]
  push_cast
  ring_nf
