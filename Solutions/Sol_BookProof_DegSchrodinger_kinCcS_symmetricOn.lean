-- Generated from ChapterDegSchrodingerCore.lean — solution of BookProof.DegSchrodinger.kinCcS_symmetricOn
import Mathlib
import Definitions.Def_ChapterDegSchrodingerCore
import Theorems.Thm_BookProof_ScalaronEsa_symmetricOn_inclusion
open BookProof.DegSchrodinger




open MeasureTheory SchwartzMap MvPolynomial
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgOneParticleCc BookProof.YangMillsHermite BookProof.HermiteProductBasis

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (S : Finset (Fin d)) : SymmetricOn (ccDomain (Vd d)) (kinCcS S) := symmetricOn_inclusion _ _ (constCoeffOp_symmetric _ _ _)
