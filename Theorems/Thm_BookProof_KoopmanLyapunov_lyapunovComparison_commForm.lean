-- Generated from ChapterKoopmanLyapunovFarisLavine.lean — theorem BookProof.KoopmanLyapunov.lyapunovComparison_commForm
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterA4
import Mathlib
import Definitions.Def_ChapterKoopmanLyapunovFarisLavine
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterYangMillsHermite
open BookProof.HermiteProductCore
open BookProof.YangMillsHermite
open BookProof.KoopmanLyapunov

variable {d : ℕ}



open MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.FarisLavine

noncomputable section


theorem BookProof.KoopmanLyapunov.lyapunovComparison_commForm {G : Fin d → MvPolynomial (Fin d) ℂ}
    (hG : ∀ i, RealCoeff (G i)) (E : MvPolynomial (Fin d) ℂ) (x : polyGaussCore (d := d)) :
    commForm (kvnGenOp G) (lyapunovComparison G E) x = commForm (kvnGenOp G) (mulCoreOp E) x := by sorry
