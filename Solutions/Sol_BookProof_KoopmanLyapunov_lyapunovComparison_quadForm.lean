-- Generated from ChapterKoopmanLyapunovFarisLavine.lean — solution of BookProof.KoopmanLyapunov.lyapunovComparison_quadForm
import Mathlib
import Definitions.Def_ChapterKoopmanLyapunovFarisLavine
import Theorems.Thm_BookProof_KoopmanLyapunov_kvnGenOp_symmetricOn
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterA4
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterYangMillsHermite
open BookProof.KoopmanLyapunov




open MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.FarisLavine
open BookProof.NsKoopman
open BookProof.HermiteProductCore
open BookProof.YangMillsHermite

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {G : Fin d → MvPolynomial (Fin d) ℂ}
    (hG : ∀ i, RealCoeff (G i)) (E : MvPolynomial (Fin d) ℂ) (x : polyGaussCore (d := d)) :
    quadForm (lyapunovComparison G E) x = ‖kvnGenOp G x‖ ^ 2 + quadForm (mulCoreOp E) x := quadForm_square_comparison (kvnGenCore G) _ (kvnGenOp_symmetricOn hG) x
