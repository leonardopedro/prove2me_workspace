-- Generated from ChapterKoopmanLyapunovFarisLavine.lean — theorem BookProof.KoopmanLyapunov.lyapunovComparison_symmetricOn
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


theorem BookProof.KoopmanLyapunov.lyapunovComparison_symmetricOn {G : Fin d → MvPolynomial (Fin d) ℂ}
    (hG : ∀ i, RealCoeff (G i)) {E : MvPolynomial (Fin d) ℂ} (hE : RealCoeff E) :
    SymmetricOn (polyGaussCore (d := d)) (lyapunovComparison G E) := by sorry
