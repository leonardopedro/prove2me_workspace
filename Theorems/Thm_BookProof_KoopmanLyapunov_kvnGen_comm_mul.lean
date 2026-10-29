-- Generated from ChapterKoopmanLyapunovFarisLavine.lean — theorem BookProof.KoopmanLyapunov.kvnGen_comm_mul
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterA4
import Mathlib
import Definitions.Def_ChapterKoopmanLyapunovFarisLavine
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterGaussCoreQuadBounds
open BookProof.YangMillsHermite



open MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.FarisLavine

noncomputable section

variable {d : ℕ}


theorem BookProof.KoopmanLyapunov.kvnGen_comm_mul (G : Fin d → MvPolynomial (Fin d) ℂ) (E p : MvPolynomial (Fin d) ℂ) :
    kvnGen G (E * p) - E * kvnGen G p = (-Complex.I) • ((∑ i, G i * pderiv i E) * p) := by sorry
