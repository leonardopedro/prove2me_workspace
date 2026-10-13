-- Generated from ChapterYangMillsNonAbelianEsa.lean — solution of BookProof.YangMillsNonAbelianEsa.op_pgLp_d
import Mathlib
import Definitions.Def_ChapterYangMillsNonAbelianEsa
import Theorems.Thm_BookProof_YangMillsNonAbelianEsa_equiv_symm_pgLp_d
import Theorems.Thm_BookProof_YangMillsHermite_CoreRep_coe_op
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterQgHermiteFriedrichs
import Definitions.Def_ChapterQgOneParticleCcEsa
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterDegSchrodingerCore
import Definitions.Def_ChapterDegKatoEsa
import Definitions.Def_ChapterHermiteGraphApprox
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterSecondQuantizationCoreEsa
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterYangMillsHermite
open BookProof.YangMillsNonAbelianEsa




open MeasureTheory MvPolynomial
open BookProof.FarisLavine BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgOneParticleCc BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.DegSchrodinger BookProof.DegKatoEsa BookProof.HermiteGraphApprox
open BookProof.TensorCore BookProof.DirectSumEsa BookProof.SecondQuantizationCore
open BookProof.HermiteProductCore
open BookProof.YangMillsHermite

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {D : Submodule ℂ F}
variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (T : Module.End ℂ (MvPolynomial (Fin d) ℂ)) (p : MvPolynomial (Fin d) ℂ) :
    (coreRepPoly d).op T ⟨pgLp p, pgLp_mem_core p⟩ = ⟨pgLp (T p), pgLp_mem_core _⟩ := by

  refine Subtype.ext ?_
  rw [CoreRep.coe_op, equiv_symm_pgLp_d]
