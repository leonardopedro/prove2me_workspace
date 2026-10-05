-- Generated from ChapterKoopmanLyapunovFarisLavine.lean — theorem BookProof.KoopmanLyapunov.mulCoreOp_symmetricOn
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterA4
import Mathlib
import Definitions.Def_ChapterKoopmanLyapunovFarisLavine
import Definitions.Def_ChapterF7
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterYangMillsHermite
open BookProof.ChapterF7
open BookProof.HermiteProductCore
open BookProof.YangMillsHermite
open BookProof.KoopmanLyapunov

variable {d : ℕ}



open MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.FarisLavine

noncomputable section


theorem BookProof.KoopmanLyapunov.mulCoreOp_symmetricOn {E : MvPolynomial (Fin d) ℂ} (hE : RealCoeff E) :
    SymmetricOn (polyGaussCore (d := d)) (mulCoreOp E) := by sorry
