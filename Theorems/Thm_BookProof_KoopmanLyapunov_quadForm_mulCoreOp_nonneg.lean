-- Generated from ChapterKoopmanLyapunovFarisLavine.lean — theorem BookProof.KoopmanLyapunov.quadForm_mulCoreOp_nonneg
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


theorem BookProof.KoopmanLyapunov.quadForm_mulCoreOp_nonneg {E : MvPolynomial (Fin d) ℂ}
    (hE : ∀ y : Vd d, 0 ≤ (MvPolynomial.eval (fun i => ((y i : ℝ) : ℂ)) E).re)
    (x : polyGaussCore (d := d)) : 0 ≤ quadForm (mulCoreOp E) x := by sorry
