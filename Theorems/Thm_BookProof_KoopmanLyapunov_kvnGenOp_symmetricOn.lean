-- Generated from ChapterKoopmanLyapunovFarisLavine.lean — theorem BookProof.KoopmanLyapunov.kvnGenOp_symmetricOn
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterA4
import Mathlib
import Definitions.Def_ChapterKoopmanLyapunovFarisLavine
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterGaussCoreQuadBounds
import Definitions.Def_ChapterShiftedQuadraticEsa
open BookProof.HermiteProductCore
open BookProof.YangMillsHermite



open MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.FarisLavine

noncomputable section

variable {d : ℕ}


theorem BookProof.KoopmanLyapunov.kvnGenOp_symmetricOn {G : Fin d → MvPolynomial (Fin d) ℂ} (hG : ∀ i, RealCoeff (G i)) :
    SymmetricOn (polyGaussCore (d := d)) (kvnGenOp G) := by sorry
