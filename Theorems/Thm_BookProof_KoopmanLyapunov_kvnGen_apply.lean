-- Generated from ChapterKoopmanLyapunovFarisLavine.lean — theorem BookProof.KoopmanLyapunov.kvnGen_apply
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterA4
import Mathlib
import Definitions.Def_ChapterKoopmanLyapunovFarisLavine
import Definitions.Def_ChapterF7
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterYangMillsHermite
open BookProof.ChapterF7
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.YangMillsHermite
open BookProof.KoopmanLyapunov

variable {d : ℕ}



open MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.FarisLavine

noncomputable section


theorem BookProof.KoopmanLyapunov.kvnGen_apply (G : Fin d → MvPolynomial (Fin d) ℂ) (p : MvPolynomial (Fin d) ℂ) :
    kvnGen G p = (-Complex.I) • ((∑ i, G i * derOp i p)
      + ((1 / 2 : ℝ) : ℂ) • ((∑ i, pderiv i (G i)) * p)) := by sorry
