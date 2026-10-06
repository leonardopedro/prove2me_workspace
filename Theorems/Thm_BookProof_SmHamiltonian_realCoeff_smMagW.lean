-- Generated from ChapterSmHamiltonian.lean — theorem BookProof.SmHamiltonian.realCoeff_smMagW
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFriedrichsExtension
import Mathlib
import Definitions.Def_ChapterSmHamiltonian
import Definitions.Def_ChapterSirkFinitePrecision
import Definitions.Def_ChapterSmOneParticle
import Definitions.Def_ChapterYangMillsHermite
open BookProof.SirkFinitePrecision
open BookProof.SirkFinitePrecision.CertInterval
open BookProof.SmOneParticle
open BookProof.YangMillsHermite
open BookProof.SmHamiltonian

variable {D : ℕ}



open MvPolynomial
open BookProof.SmOneParticle
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.HermiteProductCore BookProof.FarisLavine
open BookProof.FriedrichsExtension

noncomputable section

theorem BookProof.SmHamiltonian.realCoeff_smMagW (P : SmParams) (co : Fin 163 → Fin D) (m i : Fin 3) :
    RealCoeff (smMagW P co m i) := by sorry
