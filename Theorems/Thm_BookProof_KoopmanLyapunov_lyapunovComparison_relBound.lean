-- Generated from ChapterKoopmanLyapunovFarisLavine.lean — theorem BookProof.KoopmanLyapunov.lyapunovComparison_relBound
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterA4
import Mathlib
import Definitions.Def_ChapterKoopmanLyapunovFarisLavine
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterYangMillsHermite
open BookProof.HermiteProductCore
open BookProof.YangMillsHermite
open BookProof.KoopmanLyapunov

variable {d : ℕ}



open MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.FarisLavine

noncomputable section


theorem BookProof.KoopmanLyapunov.lyapunovComparison_relBound {G : Fin d → MvPolynomial (Fin d) ℂ}
    (hG : ∀ i, RealCoeff (G i)) {E : MvPolynomial (Fin d) ℂ}
    (hEpos : ∀ y : Vd d, 0 ≤ (MvPolynomial.eval (fun i => ((y i : ℝ) : ℂ)) E).re)
    (x : polyGaussCore (d := d)) :
    ‖kvnGenOp G x‖ ≤ ‖lyapunovComparison G E x‖ + ‖(x : L2d d)‖ := by sorry
