-- Generated from ChapterSmYukawaCoupling.lean — solution of BookProof.SmYukawaCoupling.norm_wall_sq_le_quadForm
import Mathlib
import Definitions.Def_ChapterSmYukawaCoupling
import Theorems.Thm_BookProof_SmHamiltonian_smHamiltonian_quadForm
import Definitions.Def_ChapterSmDiracYukawa
import Definitions.Def_ChapterSmCarAlgebra
import Definitions.Def_ChapterSmOneParticle
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
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterSmHamiltonian
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

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (P : SmParams) (u : polyGaussCore (d := 163)) :
    ‖((smField P wallIdx u : polyGaussCore (d := 163)) : L2d 163)‖ ^ 2
      ≤ 2 * quadForm (smHamiltonian P) u := by

  rw [smHamiltonian_quadForm]
  have h1 : 0 ≤ ∑ m, ‖((smPi m u : polyGaussCore (d := 163)) : L2d 163)‖ ^ 2 :=
    Finset.sum_nonneg fun m _ => by positivity
  have h2 : ‖((smField P wallIdx u : polyGaussCore (d := 163)) : L2d 163)‖ ^ 2
      ≤ ∑ r, ‖((smField P r u : polyGaussCore (d := 163)) : L2d 163)‖ ^ 2 :=
    Finset.single_le_sum (f := fun r => ‖((smField P r u : polyGaussCore (d := 163)) :
      L2d 163)‖ ^ 2) (fun r _ => by positivity) (Finset.mem_univ wallIdx)
  linarith
