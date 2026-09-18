import Mathlib
import Definitions.Def_ChapterNavierStokesThreeComponent
import Definitions.Def_BookProof.ChapterClosureUniqueness


open BookProof.ChapterNavierStokesThreeComponent




open Matrix
open scoped ComplexConjugate


variable {SymmetricOn (maxDom (velSym (velMu A c))) (velH A c)}


theorem velH_symmetricOn := by sorry
